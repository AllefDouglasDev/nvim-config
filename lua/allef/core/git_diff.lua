local M = {}

M.setup = function() end

-- Verifica se uma branch/ref existe
local function ref_exists(ref)
    vim.fn.system({ 'git', 'rev-parse', '--verify', ref })
    return vim.v.shell_error == 0
end

-- Obtém a branch padrão para comparação
local function get_default_branch()
    if ref_exists("origin/development") then
        return "origin/development"
    elseif ref_exists("development") then
        return "development"
    else
        vim.notify("Branch development não encontrada", vim.log.levels.WARN)
        return nil
    end
end

-- Função principal
M.git_diff = function(target_branch)
    -- Guarda o arquivo atual (caminho relativo ao repo)
    local current_file = vim.fn.expand('%:.')

    -- Se estiver num buffer GitFileDiff, usa o arquivo que gerou o diff
    local bufname = vim.fn.bufname('%')
    local from_file_diff = bufname:match("^GitFileDiff: (.+)$")
    if from_file_diff then
        current_file = from_file_diff
    end

    -- Se não informar branch, usa a padrão
    if target_branch == nil or target_branch == "" then
        target_branch = get_default_branch()
        if not target_branch then
            return
        end
    end

    -- Verifica se a branch alvo existe
    if not ref_exists(target_branch) then
        vim.notify("Branch '" .. target_branch .. "' não encontrada", vim.log.levels.ERROR)
        return
    end

    -- Executa git diff --name-only (mudanças commitadas em relação à branch alvo)
    local committed = vim.fn.systemlist({ 'git', 'diff', '--name-only', target_branch .. '...HEAD' })

    if vim.v.shell_error ~= 0 then
        vim.notify("Erro ao executar git diff", vim.log.levels.ERROR)
        return
    end

    -- Mudanças ainda não commitadas (staged e unstaged) em relação a HEAD
    local uncommitted = vim.fn.systemlist({ 'git', 'diff', '--name-only', 'HEAD' })

    -- Combina as duas listas removendo duplicados
    local seen = {}
    local output = {}
    for _, file in ipairs(committed) do
        if not seen[file] then
            seen[file] = true
            table.insert(output, file)
        end
    end
    for _, file in ipairs(uncommitted) do
        if not seen[file] then
            seen[file] = true
            table.insert(output, file)
        end
    end

    -- Cria buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_name(buf, "GitDiff: " .. target_branch)

    -- Header
    local lines = {
        "# Arquivos alterados: " .. vim.fn.system("git branch --show-current"):gsub("\n", "") .. " → " .. target_branch,
        "",
    }

    -- Adiciona arquivos
    if #output == 0 then
        table.insert(lines, "Nenhum arquivo alterado")
    else
        for _, file in ipairs(output) do
            table.insert(lines, file)
        end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)

    -- Abre em tela cheia
    vim.cmd('enew')
    vim.api.nvim_set_current_buf(buf)

    -- Posiciona o cursor no arquivo atual (se estiver na lista)
    if current_file ~= "" then
        for i, file in ipairs(output) do
            if file == current_file then
                vim.api.nvim_win_set_cursor(0, { i + 2, 0 }) -- +2 por causa do header
                break
            end
        end
    end

    -- Keymaps locais
    local opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set('n', 'q', '<cmd>bdelete<CR>', opts)
    vim.keymap.set('n', '<Esc>', '<cmd>bdelete<CR>', opts)
    vim.keymap.set('n', '<CR>', function()
        local line = vim.api.nvim_get_current_line()
        if line ~= "" and not line:match("^#") and not line:match("^Nenhum") then
            vim.cmd('bdelete')
            vim.cmd('edit ' .. vim.fn.fnameescape(line))
        end
    end, opts)
end

-- Estado dos buffers de diff: arquivo de origem e mapa linha-do-diff -> linha-do-arquivo
M._diffs = {}

-- Mapeia cada linha do diff para a linha correspondente na versão nova do arquivo
local function build_line_map(lines)
    local map = {}
    local lnum = nil
    for i, line in ipairs(lines) do
        local hunk_start = line:match("^@@ %-%d+,?%d* %+(%d+)")
        if hunk_start then
            lnum = tonumber(hunk_start)
            map[i] = lnum
        elseif lnum then
            local prefix = line:sub(1, 1)
            if prefix == "+" or prefix == " " then
                map[i] = lnum
                lnum = lnum + 1
            elseif prefix == "-" then
                -- Linha removida: aponta para onde ela estava, sem consumir uma linha nova
                map[i] = lnum
            elseif prefix ~= "\\" then
                -- Fim do hunk: cabeçalho de outro arquivo ou separador nosso
                lnum = nil
            end
        end
    end
    return map
end

-- Linha do arquivo correspondente ao cursor: exata, senão a próxima abaixo, senão acima
local function source_lnum(map, cursor, total)
    if map[cursor] then
        return map[cursor]
    end
    for i = cursor + 1, total do
        if map[i] then
            return map[i]
        end
    end
    for i = cursor - 1, 1, -1 do
        if map[i] then
            return map[i]
        end
    end
    return nil
end

-- Coluna à esquerda do diff mostrando a linha real do arquivo
M.statuscolumn = function()
    local state = M._diffs[vim.api.nvim_get_current_buf()]
    if not state then
        return "%=%l "
    end
    if vim.v.virtnum ~= 0 then
        return "%= "
    end
    return "%#LineNr#%=" .. (state.map[vim.v.lnum] or "") .. " "
end

-- Volta do buffer de diff para o arquivo, na linha sob o cursor
M.back_to_source = function()
    local buf = vim.api.nvim_get_current_buf()
    local state = M._diffs[buf]
    if not state then
        return false
    end

    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    local lnum = source_lnum(state.map, cursor, vim.api.nvim_buf_line_count(buf))

    vim.cmd('edit ' .. vim.fn.fnameescape(state.file))

    if lnum then
        lnum = math.min(lnum, vim.api.nvim_buf_line_count(0))
        vim.api.nvim_win_set_cursor(0, { lnum, 0 })
        vim.cmd('normal! zz')
    end
    return true
end

-- Função principal para diff do arquivo atual
M.git_file_diff = function(target_branch)
    -- Já num buffer de diff: sem argumento, volta para o arquivo na linha sob o cursor;
    -- com branch explícita, refaz o diff do mesmo arquivo contra ela.
    local state = M._diffs[vim.api.nvim_get_current_buf()]
    if state then
        if target_branch == nil or target_branch == "" then
            M.back_to_source()
            return
        end
        vim.cmd('edit ' .. vim.fn.fnameescape(state.file))
    end

    local current_file = vim.fn.expand('%:.')

    if current_file == "" then
        vim.notify("Nenhum arquivo aberto", vim.log.levels.WARN)
        return
    end

    if target_branch == nil or target_branch == "" then
        target_branch = get_default_branch()
        if not target_branch then
            return
        end
    end

    if not ref_exists(target_branch) then
        vim.notify("Branch '" .. target_branch .. "' não encontrada", vim.log.levels.ERROR)
        return
    end

    local committed_diff = vim.fn.systemlist({ 'git', 'diff', target_branch .. '...HEAD', '--', current_file })

    if vim.v.shell_error ~= 0 then
        vim.notify("Erro ao executar git diff", vim.log.levels.ERROR)
        return
    end

    -- Mudanças ainda não commitadas (staged e unstaged) do arquivo atual
    local uncommitted_diff = vim.fn.systemlist({ 'git', 'diff', 'HEAD', '--', current_file })

    local output = {}
    vim.list_extend(output, committed_diff)
    if #uncommitted_diff > 0 then
        if #output > 0 then
            table.insert(output, "")
        end
        table.insert(output, "# Alterações não commitadas")
        vim.list_extend(output, uncommitted_diff)
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_name(buf, "GitFileDiff: " .. current_file)

    if #output == 0 then
        output = { "# Nenhuma alteração em " .. current_file .. " em relação a " .. target_branch }
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'diff')

    M._diffs[buf] = { file = current_file, map = build_line_map(output) }

    vim.cmd('enew')
    vim.api.nvim_set_current_buf(buf)

    -- Mostra a linha do arquivo na coluna da esquerda, restaurando ao sair da janela
    local win = vim.api.nvim_get_current_win()
    local saved_stc = vim.api.nvim_get_option_value('statuscolumn', { win = win, scope = 'local' })
    vim.api.nvim_set_option_value(
        'statuscolumn',
        "%{%v:lua.require'allef.core.git_diff'.statuscolumn()%}",
        { win = win, scope = 'local' }
    )

    vim.api.nvim_create_autocmd('BufWinLeave', {
        buffer = buf,
        callback = function()
            if vim.api.nvim_win_is_valid(win) then
                pcall(vim.api.nvim_set_option_value, 'statuscolumn', saved_stc, { win = win, scope = 'local' })
            end
        end,
    })

    vim.api.nvim_create_autocmd('BufWipeout', {
        buffer = buf,
        callback = function()
            M._diffs[buf] = nil
        end,
    })

    local opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set('n', 'q', '<cmd>bdelete<CR>', opts)
    vim.keymap.set('n', '<Esc>', '<cmd>bdelete<CR>', opts)
    vim.keymap.set('n', '<CR>', function()
        M.back_to_source()
    end, opts)
end


-- Registra comando
vim.api.nvim_create_user_command('GitDiff', function(opts)
    M.git_diff(opts.args)
end, { nargs = '?' })

vim.api.nvim_create_user_command('GitFileDiff', function(opts)
    M.git_file_diff(opts.args)
end, { nargs = '?' })

-- Keymaps
vim.keymap.set('n', '<leader>gd', ':GitDiff<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gf', ':GitFileDiff<CR>', { noremap = true, silent = true })

return M
