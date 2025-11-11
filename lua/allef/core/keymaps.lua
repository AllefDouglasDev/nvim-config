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
vim.keymap.set("n", "<leader>ww", ":set wrap<CR>", options)
vim.keymap.set("n", "<leader>wo", ":set nowrap<CR>", options)

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
