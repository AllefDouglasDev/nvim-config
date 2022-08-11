require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = { 'tsx', 'lua', 'json', 'css' },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
}
