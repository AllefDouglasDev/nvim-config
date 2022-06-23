nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

lua << EOF
local telescope = require('telescope')

telescope.setup {
  defaults = {
    file_ignore_patterns = {"node_modules"}
  }
}
telescope.load_extension('fzf')
EOF
