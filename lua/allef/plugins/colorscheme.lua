return {
	"catppuccin/nvim",
	as = "catppuccin",
	dependencies = {
		"ellisonleao/gruvbox.nvim",
		"folke/tokyonight.nvim",
		"xiantang/darcula-dark.nvim",
        "blazkowolf/gruber-darker.nvim",
	},
	priority = 1000,
	config = function()
		local gruvbox = require("gruvbox")

		gruvbox.setup({
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				operators = true,
				comments = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			-- palette_overrides = {
			--     dark0_hard = "#18191A"
			-- },
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})

		-- vim.opt.background = "dark"
        -- vim.cmd("colorscheme gruber-darker")
		vim.cmd("colorscheme darcula-dark")
		-- vim.cmd("colorscheme gruvbox")
		-- vim.cmd("colorscheme catppuccin-mocha")
		-- vim.cmd("colorscheme poimandres")
		-- vim.cmd("colorscheme tokyonight-night")

	end,
}
