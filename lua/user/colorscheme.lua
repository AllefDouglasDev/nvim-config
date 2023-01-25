-- ayu configs
vim.cmd([[ let ayucolor="mirage" ]])

-- vscode configs
vim.g.vscode_style = "dark"
vim.g.vscode_transparency = 1
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = "true"

-- tokyonight
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

-- gruvbox nvim
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {
    dark0_hard = "#18191A"
  },
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd([[ colorscheme tokyonight ]])
