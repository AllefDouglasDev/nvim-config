vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false -- Usar tabs em vez de espaços
vim.opt_local.smarttab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- Mostrar tabs/espaços visualmente
-- vim.opt_local.list = true
-- vim.opt_local.listchars = {
-- 	tab = "→ ",
-- 	space = "·",
-- 	trail = "•",
-- 	extends = "❯",
-- 	precedes = "❮",
-- }

-- Converter espaços para tabs
vim.api.nvim_create_user_command("SpacesToTabs", function()
	vim.cmd("%s/    /\t/g")
end, {})

-- Converter tabs para espaços
vim.api.nvim_create_user_command("TabsToSpaces", function()
	vim.cmd("%s/\t/    /g")
end, {})

-- Corrigir indentação mista automaticamente
vim.api.nvim_create_user_command("FixIndentation", function()
	-- Para seu projeto que usa tabs
	vim.cmd("%s/^    /\t/g") -- 4 espaços -> 1 tab
	vim.cmd("%s/^\t    /\t\t/g") -- tab + 4 espaços -> 2 tabs
end, {})

