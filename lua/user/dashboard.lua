local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[  ]],
  [[ ██╗   ██╗ ██╗ ███╗   ███╗ ]],
  [[ ██║   ██║ ██║ ████╗ ████║ ]],
  [[ ██║   ██║ ██║ ██╔████╔██║ ]],
  [[ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
  [[  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
  [[   ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", '<Cmd>lua require("telescope.builtin").find_files({ no_ignore = false, hidden = true })<CR>'),
	dashboard.button("e", "  New file", ":ene <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

local function footer()
  vim.cmd([[ :file Alpha ]])
	return "Allef Douglas"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
