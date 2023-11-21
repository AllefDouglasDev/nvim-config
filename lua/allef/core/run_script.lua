function run_script()
    local buffer_name = "run.sh"
    local existing_bufnr = vim.fn.bufnr(buffer_name)
    if existing_bufnr ~= -1 then
        vim.api.nvim_buf_delete(existing_bufnr, { force = true })
    end
    local new_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(new_bufnr, buffer_name)
    vim.cmd('vsplit')
    vim.api.nvim_set_current_buf(new_bufnr)
    vim.api.nvim_buf_set_option(new_bufnr, 'bufhidden', 'wipe')
    vim.fn.termopen('./run.sh', { detach = 1 })
    vim.cmd('normal! G')
end

vim.api.nvim_set_keymap('n', '<leader>rs', ':lua run_script()<CR>', { noremap = true, silent = true })
