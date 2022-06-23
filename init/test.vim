nnoremap <silent> tt :TestNearest<CR>
nnoremap <silent> tf :TestFile<CR>
nnoremap <silent> ts :TestSuit<CR>
nnoremap <silent> t_ :TestLast<CR>
let test#strategy = 'neovim'
let test#neovim#term_position = 'vertical'
