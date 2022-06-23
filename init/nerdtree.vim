let g:NERDTreeGitStatusWithFlags = 1
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
