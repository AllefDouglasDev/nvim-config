vim.cmd [[packadd packer.nvim]]
vim.env.OPENAI_API_KEY = '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'

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- General
  use 'lewis6991/impatient.nvim'
  use 'tpope/vim-commentary'
  use 'alvan/vim-closetag'
  use 'tpope/vim-surround'
  use 'ap/vim-css-color'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'ThePrimeagen/harpoon'

  -- Tailwind
  use 'roobert/tailwindcss-colorizer-cmp.nvim'
  use 'NvChad/nvim-colorizer.lua'
  use {
    'themaxmarchuk/tailwindcss-colors.nvim',
    module = 'tailwindcss-colors',
  }

  -- Colorscheme
  use 'ellisonleao/gruvbox.nvim'
  use 'joshdick/onedark.vim'
  use 'Mofiqul/vscode.nvim'
  use 'folke/tokyonight.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'shaunsingh/moonlight.nvim'

  use 'rest-nvim/rest.nvim'

  -- Window Style
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  -- use 'moll/vim-bbye'
  -- use 'akinsho/bufferline.nvim'
  -- use 'nvim-lualine/lualine.nvim'
  -- use 'goolord/alpha-nvim'
  -- use 'karb94/neoscroll.nvim'

  -- Tree
  use 'nvim-tree/nvim-tree.lua'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- Git
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- Tests
  -- use 'janko/vim-test'

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'nvim-treesitter/nvim-treesitter-context'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
  use 'styled-components/vim-styled-components'

  -- DAP
  -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  -- use 'theHamsta/nvim-dap-virtual-text'
  -- use 'leoluz/nvim-dap-go'

  -- AI Completion
  use {
    'Exafunction/codeium.vim',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }

  -- Obsidian
  use 'epwalsh/obsidian.nvim'
end)
