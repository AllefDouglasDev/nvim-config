"==============================================================================
"general
"==============================================================================

set number
set relativenumber
set mouse=a
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set updatetime=300
set shortmess+=c 
set signcolumn=yes
set laststatus=3
set noswapfile
set noerrorbells
set incsearch
set scrolloff=8
set colorcolumn=0
set termguicolors     
set guicursor=
set foldlevel=99
set foldclose=all
set foldmethod=indent
set cursorline
set splitbelow
set splitright

"==============================================================================
"plugins
"==============================================================================

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SmiteshP/nvim-navic'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'kdheepak/lazygit.nvim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'overcache/NeoSolarized'
Plug 'janko/vim-test'
Plug 'christoomey/vim-tmux-navigator'
" svelte development
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
" debuggin
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'Pocco81/DAPInstall.nvim', {'branch': 'dev'}
" tabs
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let mapleader = " "

"==============================================================================
"theme
"==============================================================================

" ayu configs
let ayucolor="mirage" 

" vscode configs
let g:vscode_style = "dark"
let g:vscode_transparency = 1
let g:vscode_italic_comment = 1
let g:vscode_disable_nvimtree_bg = v:true

" neosolarized
let g:neosolarized_vertSplitBgTrans = 1

" tabs - vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='ayu_mirage'

colorscheme onedark

"==============================================================================
"configs
"==============================================================================

" clean search highlight
nnoremap <c-x> :noh<CR>

" select all ts files into args
function! SelectTS()
  args `find src -name '*.ts'`
  bd
endfunction

" copy co clipboard
nnoremap <silent>cp :y+<CR>  
vnoremap <silent>cp "+y<CR>  

" esc
inoremap jk <ESC>

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx'

"==============================================================================
" file navigation
"==============================================================================

" Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
lua << EOF
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {"node_modules"}
  }
}
require('telescope').load_extension('fzf')
EOF

" LSP Installer Config
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
EOF

lua << EOF
local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
EOF

" Highlight
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust" },
  sync_install = false,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
  },
}
EOF

" Prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" NERDTree
let g:NERDTreeGitStatusWithFlags = 1
"let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeIgnore = ['^.DS_Store$']
let g:NERDTreeShowHidden = 1

function! NerdTreeToggleFind()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction

nmap <C-n> :call NerdTreeToggleFind()<CR>

"==============================================================================
" autocomplete
"==============================================================================

" coc config
let g:coc_global_extensions = [
  \ 'coc-omnisharp',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-phpls', 
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of current line
vmap ac <Plug>(coc-codeaction)
nmap ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
vmap qf <Plug>(coc-fix-current)
nmap qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" lazygit
nnoremap <leader>m :LazyGit<cr>

" try to access cht.sh
function! ChtSh(lang, query)
  let new_query = substitute(a:query, ' ', '+', 'g')
  let new_url = 'cheat.sh/' . a:lang . '/' . new_query
  :split
  execute 'term curl ' . new_url 
  let file_name = new_url . ' - ' . bufnr('%')
  echo file_name
  execute 'file ' . file_name
endfunction

"==============================================================================
" tests
"==============================================================================

" janko/vim-test
nnoremap <silent> tt :TestNearest<CR>
nnoremap <silent> tf :TestFile<CR>
nnoremap <silent> ts :TestSuit<CR>
nnoremap <silent> t_ :TestLast<CR>
let test#strategy = 'neovim'
let test#neovim#term_position = 'vertical'

"==============================================================================
" degub
"==============================================================================

nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>do :lua require'dap'.step_over()<cr>
nnoremap <leader>di :lua require'dap'.step_into()<cr>
nnoremap <leader>dc :lua require'dap'.continue()<cr>
nnoremap <leader>dk :lua require'dap'.repl.open()<cr>
nnoremap <leader>ui :lua require('dapui').toggle()<cr>

lua << EOF
local dap = require('dap')
local dapui = require("dapui")
local dap_install = require("dap-install")

dapui.setup()

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})
dap_install.config('chrome', {})

-- Node Debug
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.config/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    port = 9229,
  },
}
EOF
