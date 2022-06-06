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
set statusline+=\ %f%m
set noswapfile
set noerrorbells
set incsearch
set scrolloff=8
set colorcolumn=80
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
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kdheepak/lazygit.nvim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'janko/vim-test'
Plug 'puremourning/vimspector'
call plug#end()

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

colorscheme ayu

"==============================================================================
"configs
"==============================================================================

" clean search highlight
nnoremap <c-x> :noh<CR>

" Moving between panels
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx'

" Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <Space>fg :Telescope live_grep<CR>
nnoremap <Space>fb :Telescope buffers<CR>
nnoremap <Space>fh :Telescope help_tags<CR>
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

inoremap jk <ESC>
nmap <C-n> :call NerdTreeToggleFind()<CR>
vmap gc <plug>NERDCommenterToggle
nmap gc <plug>NERDCommenterToggle

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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <Space>gd :OmniSharpGotoDefinition<CR>
nmap <Space>gi :OmniSharpFindImplementations<CR>
nmap <Space>K :OmniSharpDocumentation<CR>

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
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" lazygit
nnoremap <space>m :LazyGit<cr>

" try to access cht.sh
function! ChtSh(lang, query)
  let new_query = substitute(a:query, ' ', '+', 'g')
  let new_url = 'cheat.sh/' . a:lang . '/' . new_query
  :split
  execute 'term curl ' . new_url 
endfunction

" janko/vim-test
nnoremap <silent> tt :TestNearest<CR>
nnoremap <silent> tf :TestFile<CR>
nnoremap <silent> ts :TestSuit<CR>
nnoremap <silent> t_ :TestLast<CR>
let test#strategy = 'neovim'
let test#neovim#term_position = 'vertical'

" puremourning/vimspector
nnoremap <Space>da :call vimspector#Launch()<CR>
nnoremap <Space>dx :call vimspector#Reset()<CR>
nnoremap <Space>k :call vimspector#StepOut()<CR>
nnoremap <Space>l :call vimspector#StepInto()<CR>
nnoremap <Space>j :call vimspector#StepOver()<CR>
nnoremap <Space>d_ :call vimspector#Restart()<CR>
nnoremap <Space>dn :call vimspector#Continue()<CR>
nnoremap <Space>drc :call vimspector#RunToCursor()<CR>
nnoremap <Space>dh :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Space>de :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <Space>dX :call vimspector#ClearBreakpoints()<CR>
func! AddToWatch()
  let word = expand("<cexpr>")
  call vimspector#AddWatch(word)
endfunction
let g:vimspector_base_dir = expand('$HOME/.config/nvim/vimspector-config')

" janko/vim-test and puremourning/vimspector
function! JestStrategy(cmd)
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  call vimspector#LaunchWithSettings( #{ configuration: 'jest', TestName: testName } )
endfunction
let g:test#custom_strategies = {'jest': function('JestStrategy')}
nnoremap <Space>dd :TestNearest -strategy=jest<CR>

