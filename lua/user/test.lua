vim.cmd([[ let test#strategy = 'neovim' ]])
vim.cmd([[ let test#neovim#term_position = 'vertical' ]])

local options = { noremap = true, silent = true }
vim.keymap.set('n', 'tt', ':TestNearest<CR>', options)
vim.keymap.set('n', 'tf', ':TestFile<CR>', options)
vim.keymap.set('n', 'ts', ':TestSuit<CR>', options)
vim.keymap.set('n', 't_', ':TestLast<CR>', options)
