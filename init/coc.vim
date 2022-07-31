command! -nargs=0 Prettier :CocCommand prettier.formatFile

" let g:coc_global_extensions = [
  " \ 'coc-snippets',
  " \ 'coc-pairs',
  " \ 'coc-tsserver',
  " \ 'coc-eslint', 
  " \ 'coc-prettier', 
  " \ 'coc-json', 
  " \ ]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>r <Plug>(coc-rename)

vmap ac <Plug>(coc-codeaction)
nmap ac <Plug>(coc-codeaction)
vmap qf <Plug>(coc-fix-current)
nmap qf <Plug>(coc-fix-current)

vnoremap <leader>ac <Plug>(coc-codeaction) 
