require("telescope").load_extension('harpoon')
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>af', mark.add_file, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', ui.toggle_quick_menu, { noremap = true, silent = true })
