require('impatient')
-- vim-closetag
vim.cmd([[ let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx' ]])
require("nvim-autopairs").setup {}

vim.cmd([[ 
  let g:limelight_conceal_ctermfg = 100
  let g:limelight_conceal_guifg = '#777777'
]])

require 'colorizer'.setup()
