local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local lspsaga = require('lspsaga')

lspconfig.setup = {}
lspsaga.setup({})

lsp_installer.on_server_ready(function(server)
    local opts = {
---@diagnostic disable-next-line: unused-local
      on_attach = function(client, bufnr)
        if client.name == "tsserver" then
          client.server_capabilities.document_formatting = false
        end
      end
    }
    server:setup(opts)
end)

lspsaga.init_lsp_saga = {
  server_filetype_map = {}
}

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', bufopts)
vim.keymap.set('n', '<leader>sd', '<Cmd>Telescope diagnostics<CR>', bufopts)
vim.keymap.set("n", "<leader>rt", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Native LSP
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '<leader>p', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, bufopts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)
vim.keymap.set('n', 'ac', vim.lsp.buf.code_action, bufopts)

-- With Lspsaga
-- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', bufopts)
-- vim.keymap.set('n', '<leader>r', '<Cmd>Lspsaga rename<CR>', bufopts)
-- vim.keymap.set('n', '<leader>x', '<Cmd>Lspsaga show_line_diagnostics<CR>', bufopts)
-- vim.keymap.set('n', '<leader>p', '<Cmd>Lspsaga peek_definition<CR>', bufopts)
-- vim.keymap.set('n', '<leader>df', '<Cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)
-- vim.keymap.set('n', 'ac', '<Cmd>Lspsaga code_action<CR>', bufopts)

