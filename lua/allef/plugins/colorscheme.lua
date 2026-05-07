return {
	{
		"xiantang/darcula-dark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme darcula-dark")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "blazkowolf/gruber-darker.nvim", lazy = true },
}
