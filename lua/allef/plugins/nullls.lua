return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "MunifTanjim/prettier.nvim" },
    config = function()
        local null_ls = require("null-ls")
        local prettier = require("prettier")

        prettier.setup = {
            bin = 'prettierd',
            filetypes = {
                'css',
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'json',
                'scss',
                'less'
            }
        }

        -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local formatting = null_ls.builtins.formatting
        null_ls.setup({
            debug = false,
            sources = {
                formatting.prettier,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.diagnostics.eslint_d,
            },
        })

        local options = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>fc', vim.lsp.buf.format, options)
    end
}
