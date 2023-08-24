local dapui = require('dapui')
local dap_go = require('dap-go')
local icons = require('user.icons')

dapui.setup()
dap_go.setup()

vim.fn.sign_define('DapBreakpoint', { text = icons.ui.Bug, texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text = icons.ui.ArrowCircleRight, texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.keymap.set('n', '<leader>dt', dapui.toggle, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>di', ":DapStepInto<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>do', ":DapStepOver<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dr', ":lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true })
