return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		lspconfig.setup = {}
		mason.setup()
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"cssls",
				"rust_analyzer",
				"tailwindcss",
			},
		})

		-- Configuring borders
		vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
		vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])
		local border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		}
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- Diagnostics kinds
		vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

		-- Keymaps
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", bufopts)
		vim.keymap.set("n", "<leader>sd", "<Cmd>Telescope diagnostics<CR>", bufopts)
		vim.keymap.set("n", "<leader>rt", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

		-- Native LSP
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float, bufopts)
		vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, bufopts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)
		vim.keymap.set("n", "ac", vim.lsp.buf.code_action, bufopts)
	end,
}
