return {
    'tpope/vim-dadbod',
    dependencies = {
        'kristijanhusak/vim-dadbod-ui',
    },
    config = function()
        vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
    end
}

-- Connections examples

-- let g:dbs = [
-- \ { 'name': 'dev', 'url': 'postgres://postgres:mypassword@localhost:5432/my-dev-db' }
-- \ { 'name': 'staging', 'url': 'postgres://postgres:mypassword@localhost:5432/my-staging-db' },
-- \ { 'name': 'wp', 'url': 'mysql://root@localhost/wp_awesome' },
-- \ { 'name': 'production', 'url': function('s:resolve_production_url') },
-- \ ]
