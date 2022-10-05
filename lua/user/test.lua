vim.cmd([[ let test#strategy = 'neovim' ]])
vim.cmd([[ let test#neovim#term_position = 'vertical' ]])
vim.cmd([[ let test#javascript#jest#executable='pnpm --filter main test' ]])
vim.cmd([[ let g:test#preserve_screen = 1 ]])
vim.cmd([[ let g:test#neovim#start_normal = 1 ]])

local options = { noremap = true, silent = true }
vim.keymap.set('n', 'tt', ':TestNearest<CR>', options)
vim.keymap.set('n', 'tf', ':TestFile<CR>', options)
vim.keymap.set('n', 'ts', ':TestSuit<CR>', options)
vim.keymap.set('n', 'tl', ':TestLast<CR>', options)
