function! CloseBuffers()
  execute '%bd | e#'
endfunction

function! SelectTS()
  args `find src -name '*.ts'`
  bd
endfunction

function! ChtSh(lang, query)
  let new_query = substitute(a:query, ' ', '+', 'g')
  let new_url = 'cheat.sh/' . a:lang . '/' . new_query
  :split
  execute 'term curl ' . new_url 
  let file_name = new_url . ' - ' . bufnr('%')
  echo file_name
  execute 'file ' . file_name
endfunction

let mapleader = " "

" clean search highlight
nnoremap <C-x> :noh<CR>

" copy co clipboard
nnoremap <silent>cp :y+<CR>  
vnoremap <silent>cp "+y<CR>  

nnoremap <C-w>k :call CloseBuffers()<CR>

inoremap jk <ESC>

nnoremap <C-w>a :bufdo :Bdelete<CR>
