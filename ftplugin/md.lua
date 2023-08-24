local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gd', '<Cmd>ObsidianFollowLink<CR>', bufopts)
