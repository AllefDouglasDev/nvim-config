lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = function(client, bufnr)
        if client.name == "tsserver" then
          client.resolved_capabilities.document_formatting = false
        end
      end    
    }
    server:setup(opts)
end)

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
EOF
        " lsp_keymaps(bufnr)
        " lsp_highlight_document(client)
