local M = {}

M.setup = function() end

M.open_todo = function()
	-- Caminho do arquivo de todo
	local todo_file = vim.fn.expand("~/notes/000_todo.md")

	-- Criar buffer para o arquivo
	local buf = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

	-- Carregar o arquivo no buffer
	vim.api.nvim_buf_call(buf, function()
		vim.cmd('edit ' .. todo_file)
	end)

	-- Configurações da janela popup
	local ui = vim.api.nvim_list_uis()[1]
	local win_width = ui.width
	local win_height = ui.height

	-- Calcular 80% da tela com limites mínimo e máximo
	local width = math.floor(win_width * 0.8)
	local height = math.floor(win_height * 0.6)

	-- Calcular posição centralizada
	local col = math.floor((win_width - width) / 2)
	local row = math.floor((win_height - height) / 2)

	-- Opções da janela flutuante
	local opts = {
		relative = 'editor',
		width = width,
		height = height,
		col = col,
		row = row,
		style = 'minimal',
		border = 'rounded'
	}

	-- Criar a janela flutuante
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Configurações adicionais da janela
	vim.api.nvim_win_set_option(win, 'wrap', true)
	vim.api.nvim_win_set_option(win, 'cursorline', true)

	-- Keymap para fechar a janela com 'q' ou ESC
	local keymaps_opts = { noremap = true, silent = true, buffer = buf }
	vim.keymap.set('n', 'q', '<cmd>close<CR>', keymaps_opts)
	vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', keymaps_opts)
end

-- Criar comando de usuário
vim.api.nvim_create_user_command("Todo", function()
	M.open_todo()
end, {})

-- Definir keymap para o comando de usuário
vim.keymap.set('n', '<leader>tt', ':Todo<CR>', { noremap = true, silent = true })

return M
