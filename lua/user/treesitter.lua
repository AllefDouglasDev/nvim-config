require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = { 
    'css',
    'http',
    'json',
    'lua',
    'prisma',
    'query',
    'rust',
    'toml',
    'tsx',
    'typescript'
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  }
}

