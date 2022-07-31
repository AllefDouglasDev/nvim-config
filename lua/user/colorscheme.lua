-- ayu configs
vim.cmd([[ let ayucolor="mirage"  ]])

-- vscode configs
vim.cmd([[ let g:vscode_style = "dark" ]])
vim.cmd([[ let g:vscode_transparency = 1 ]])
vim.cmd([[ let g:vscode_italic_comment = 1 ]])
vim.cmd([[ let g:vscode_disable_nvimtree_bg = v:true ]])

-- tabs - vim-airline
-- vim.cmd([[ let g:airline#extensions#tabline#enabled = 1 ]])
-- vim.cmd([[ let g:airline#extensions#tabline#left_sep = ' ' ]])
-- vim.cmd([[ let g:airline#extensions#tabline#left_alt_sep = '|' ]])
-- vim.cmd([[ let g:airline#extensions#tabline#formatter = 'unique_tail' ]])
-- vim.cmd([[ let g:airline_theme='ayu_mirage' ]])

-- tokyonight
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

vim.cmd([[ colorscheme tokyonight ]])
