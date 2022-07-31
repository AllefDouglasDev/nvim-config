" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx'
lua << EOF
require("nvim-autopairs").setup {}
EOF
