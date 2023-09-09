require('impatient')
-- vim-closetag
vim.cmd([[ let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx' ]])
require("nvim-autopairs").setup {}

vim.cmd([[ 
  let g:limelight_conceal_ctermfg = 100
  let g:limelight_conceal_guifg = '#777777'
]])

require 'colorizer'.setup()

function RunScript()
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
end

vim.api.nvim_set_keymap('n', '<leader>rs', ':lua RunScript()<CR>', { noremap = true, silent = true })
