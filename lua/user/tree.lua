-- disable netrw at the very start of your init.lua
vim.g.loaded = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup()

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')
