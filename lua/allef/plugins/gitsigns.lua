return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "契" },
			topdelete = { text = "契" },
			changedelete = { text = "▎" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 300,
			ignore_whitespace = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
	config = function()
		vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
		vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "DiffAdd" })
		vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "DiffChange" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "DiffDelete" })
		vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "DiffAdd" })
		vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "DiffChange" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "DiffDelete" })
	end,
}
