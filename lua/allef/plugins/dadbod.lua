return {
    'tpope/vim-dadbod',
    dependencies = {
        'kristijanhusak/vim-dadbod-ui',
    },
    config = function()
        vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
    end
}
