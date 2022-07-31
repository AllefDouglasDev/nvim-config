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

lspconfig.tailwindcss.setup {
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          "tw=\"([^\"]*)",
          "tw={\"([^\"}]*)",
          "tw\\.\\w+`([^`]*)",
          "tw\\(.*?\\)`([^`]*)"
        }
      },
      validate = true
    }
  }
}

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, bufopts)
vim.keymap.set('n', 'ac', vim.lsp.buf.code_action, bufopts)
