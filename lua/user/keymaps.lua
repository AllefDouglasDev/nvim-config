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
vim.keymap.set('n', '<C-x>', ':noh<CR>', options)
vim.keymap.set('n', '<C-w>k', ':call CloseBuffers()<CR>', options)
vim.keymap.set('i', 'jk', '<ESC>', options)
vim.keymap.set('n', '<C-w>a', ':bufdo :Bdelete<CR>', options)
vim.keymap.set('n', '<leader>l', ':vertical resize -5<CR>', options)
vim.keymap.set('n', '<leader>h', ':vertical resize +5<CR>', options)
vim.keymap.set('n', '<leader>j', ':resize -5<CR>', options)
vim.keymap.set('n', '<leader>k', ':resize +5<CR>', options)
