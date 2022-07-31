vim.cmd([[ 
  function! CloseBuffers()
    execute '%bd | e#'
  endfunction
]])

vim.cmd([[ 
  function! SelectTS()
    args `find src -name '*.ts'`
    bd
    echo "All ts files selected"
  endfunction
]])

vim.cmd([[ 
  function! ChtSh(lang, query)
    let new_query = substitute(a:query, ' ', '+', 'g')
    let new_url = 'cheat.sh/' . a:lang . '/' . new_query
    :split
    execute 'term curl ' . new_url 
    let file_name = new_url . ' - ' . bufnr('%')
    echo file_name
    execute 'file ' . file_name
  endfunction
]])

local options = { noremap = true, silent = true }
vim.cmd([[ let mapleader = " " ]])
-- clean search highlight
vim.keymap.set('n', '<C-x>', ':noh<CR>', options)
-- copy co clipboard
vim.keymap.set('n', 'cp', '"+y<CR>', options)
-- nnoremap <C-w>k :call CloseBuffers()<CR>
vim.keymap.set('n', '<C-w>k', ':call CloseBuffers()<CR>', options)
-- inoremap jk <ESC>
vim.keymap.set('i', 'jk', '<ESC>', options)
-- nnoremap <C-w>a :bufdo :Bdelete<CR>
vim.keymap.set('n', '<C-w>a', ':bufdo :Bdelete<CR>', options)

