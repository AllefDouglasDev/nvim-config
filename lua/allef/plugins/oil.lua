return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local oil = require("oil")
			oil.setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
				},
			})

			vim.keymap.set("n", "-", ":Oil<cr>", { noremap = true, silent = true, desc = "Open parent directory" })
			vim.keymap.set("n", "<C-n>", ":Oil<cr>", { noremap = true, silent = true, desc = "Open parent directory" })
			vim.keymap.set(
				"n",
				"<space>-",
				oil.toggle_float,
				{ noremap = true, silent = true, desc = "Open parent directory" }
			)
		end,
	},
}
