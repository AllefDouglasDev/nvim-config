return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		require("nvim-dap-virtual-text").setup()
		require("dapui").setup()

		local dap = require("dap")
		local dapui = require("dapui")
		require("telescope").load_extension("dap")
		dapui.setup({})
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		-- NodeJS NestJS configuration
		dap.adapters.node2 = {
			type = "executable",
			command = "node-debug2-adapter",
			args = { "--inspect-brk" },
		}

		dap.configurations.javascript = {
			{
				name = "Launch NestJS",
				type = "node2",
				request = "launch",
				program = "${workspaceFolder}/dist/main.js", -- O arquivo compilado do NestJS
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				name = "Attach to NestJS",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				name = "Debug NestJS Tests",
				type = "node2",
				request = "launch",
				program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
				args = { "--runInBand" },
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
				skipFiles = { "<node_internals>/**" },
			},
		}

		dap.configurations.typescript = {
			{
				name = "Launch NestJS (TS)",
				type = "node2",
				request = "launch",
				program = "${workspaceFolder}/src/main.ts", -- Arquivo principal do NestJS
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				preLaunchTask = "tsc: build", -- Se você estiver usando um processo de build com TypeScript
				outFiles = { "${workspaceFolder}/dist/**/*.js" },
				console = "integratedTerminal",
			},
			{
				name = "Attach to NestJS",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				name = "Debug NestJS Tests",
				type = "node2",
				request = "launch",
				program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
				args = { "--runInBand", "--watch" },
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				outFiles = { "${workspaceFolder}/dist/**/*.js" },
				console = "integratedTerminal",
			},
		}

		dap.adapters.lldb = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			name = "lldb",
		}

		dap.adapters.cppdbg = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
			name = "cppdbg",
		}

		dap.configurations.c = {
			{
				name = "Launch",
				type = "lldb", -- or "cppdbg" for GDB
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		-- Configuring keymaps
		vim.keymap.set("n", "<leader>dd", dap.continue, {})
		vim.keymap.set("n", "<leader>de", dap.terminate, {})
		vim.keymap.set("n", "<leader>dn", dap.step_over, {})
		vim.keymap.set("n", "<leader>dsi", dap.step_into, {})
		vim.keymap.set("n", "<leader>dso", dap.step_out, {})
		vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>di", dapui.toggle, {})
	end,
}
