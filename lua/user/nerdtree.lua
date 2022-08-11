vim.cmd([[ let g:NERDTreeGitStatusWithFlags = 1 ]])
vim.cmd([[ let g:NERDTreeIgnore = ['^.DS_Store$'] ]])
vim.cmd([[ let g:NERDTreeShowHidden = 1 ]])

vim.cmd([[ 
  function! NerdTreeToggleFind()
      if bufname('') == 'Alpha'
        Alpha
      endif
      if exists("g:NERDTree") && g:NERDTree.IsOpen()
          NERDTreeClose
      elseif filereadable(expand('%'))
          NERDTreeFind
      else
          NERDTree
      endif
  endfunction
]])

-- vim.keymap.set('n', '<C-n>')
-- nmap <C-n> :call NerdTreeToggleFind()<CR>
vim.keymap.set('n', '<C-n>', ':call NerdTreeToggleFind()<CR>')
