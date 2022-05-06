"====================================================================================
"general
"====================================================================================

set number
set mouse=a
set relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set updatetime=300
set shortmess+=c 
set signcolumn=yes
set laststatus=2
set statusline+=\ %f%m
set noswapfile

"====================================================================================
"plugins
"====================================================================================

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'github/copilot.vim'
Plug 'christoomey/vim-tmux-navigator'
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
Plug 'akinsho/toggleterm.nvim'
" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'Mofiqul/vscode.nvim'

call plug#end()

"====================================================================================
"configs
"====================================================================================

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.php,*.tsx'

" Fuzzy find telescope
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

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeShowHidden = 1

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" NERDTree
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

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

nmap <c-s> :w<CR>
xmap <c-s> <Esc>:w<CR>a

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Copilot disable
let g:copilot_filetypes = {
      \ '*': v:false,
      \ }

" Theme configuration
" For dark theme
let g:vscode_style = "dark"
" Enable transparent background.
let g:vscode_transparency = 1
" Enable italic comment
let g:vscode_italic_comment = 1
" Disable nvim-tree background color 
let g:vscode_disable_nvimtree_bg = v:true

set termguicolors     
let ayucolor="mirage" 
colorscheme ayu

" Toggle Terminal Configurations
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

function! TVertical() 
  ToggleTerm direction=vertical
endfunction

function! THorizontal() 
  ToggleTerm direction=horizontal
endfunction

function! TFloat() 
  ToggleTerm direction=float
endfunction

lua << EOF
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF

function! _LAZYGIT()
  lua _lazygit_toggle()
endfunction

autocmd! TermOpen term://* lua set_terminal_keymaps()

nmap <space>m :call _LAZYGIT()<cr>

lua << EOF
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, 
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, 
  start_in_insert = true,
  insert_mappings = true, 
  terminal_mappings = true, 
  persist_size = true,
  direction = 'float',
  close_on_exit = true, 
  shell = vim.o.shell, 
  float_opts = {
    border = 'curved',
    winblend = 0
  }
}
EOF

"source $HOME/.config/nvim/themes/onedark.vim
