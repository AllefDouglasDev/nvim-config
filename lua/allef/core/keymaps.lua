local options = { noremap = true, silent = true }
vim.cmd([[ let mapleader = " " ]])
vim.keymap.set('i', 'jk', '<ESC>', options)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', options)
vim.keymap.set('n', '<leader>l', ':vertical resize -5<CR>', options)
vim.keymap.set('n', '<leader>h', ':vertical resize +5<CR>', options)
vim.keymap.set('n', '<leader>j', ':resize -5<CR>', options)
vim.keymap.set('n', '<leader>k', ':resize +5<CR>', options)
vim.keymap.set('n', '<C-x>', ':noh<CR>', options)
vim.keymap.set("n", "<C-d>", "<C-d>zz", options)
vim.keymap.set("n", "<C-u>", "<C-u>zz", options)
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", options)
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", options)
vim.keymap.set("n", "<leader>qc", function()
	local items = {}
	for _, line in ipairs(vim.split(vim.fn.getreg("+"), "\n")) do
		local path = vim.trim(line)
		if path ~= "" and vim.fn.filereadable(path) == 1 then
			table.insert(items, { filename = path, lnum = 1 })
		end
	end
	if #items == 0 then
		vim.notify("Nenhum arquivo valido no clipboard", vim.log.levels.WARN)
		return
	end
	vim.fn.setqflist(items)
	vim.cmd("copen")
end, { noremap = true, silent = true, desc = "Quickfix a partir do clipboard" })
vim.keymap.set("n", "<leader>ww", ":set wrap<CR>", options)
vim.keymap.set("n", "<leader>wo", ":set nowrap<CR>", options)
vim.keymap.set("n", "<leader>nn", function ()
	vim.notify("Hello world", vim.log.levels.INFO)
end, options)

-- vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', options)
-- vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>', options)


-- Run in background
vim.keymap.set('n', '<leader>mp', ':!md %<CR>', { desc = 'Markdown Preview' })
--
-- -- Remapeamentos para deleção e alteração de texto (não copiar para o registro padrão)
-- vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true })

-- -- Remapeamento adicional para 'dd' e 'cc' não copiarem para o registro padrão
-- vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'cc', '"_cc', { noremap = true, silent = true })

-- -- Remapeamento para usar 'm' como cortar (deletar e copiar para o registro padrão)
-- vim.api.nvim_set_keymap('n', 'm', 'd', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'm', 'd', { noremap = true, silent = true })

-- -- Mapeia o comando de cola (p) para não substituir o registrador padrão
-- vim.api.nvim_set_keymap('n', 'p', '"_p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'p', '"_p', { noremap = true, silent = true })
