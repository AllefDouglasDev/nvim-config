local telescope = require('telescope')

telescope.setup {
  defaults = {
    file_ignore_patterns = {"node_modules"}
  }
}
telescope.load_extension('fzf')

local options = { noremap = true, silent = true }
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', options)
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', options)
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', options)
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', options)
