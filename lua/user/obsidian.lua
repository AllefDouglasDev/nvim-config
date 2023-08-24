require('obsidian').setup({
  dir = "~/Documents/dev/notes/",
})

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gl', '<Cmd>ObsidianFollowLink<CR>', bufopts)

