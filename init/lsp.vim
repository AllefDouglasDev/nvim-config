lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
EOF
