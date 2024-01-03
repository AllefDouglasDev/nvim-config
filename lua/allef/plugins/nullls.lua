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

        local function contains_any_ignore_case(inputString, stringsToCompare)
            for _, searchString in ipairs(stringsToCompare) do
                local pattern = string.gsub(searchString, "[%a]", function(c)
                    return "[" .. string.lower(c) .. string.upper(c) .. "]"
                end)
                if string.find(inputString, pattern) then
                    return true
                end
            end
            return false
        end

        local formatting = null_ls.builtins.formatting
        null_ls.setup({
            debug = false,
            sources = {
                formatting.stylua,
                formatting.prettier,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.diagnostics.eslint_d.with({
                    filter = function(diagnostic)
                        local ignore = { "no eslint configuration found" }
                        return not contains_any_ignore_case(diagnostic.message, ignore)
                    end,
                }),
            },
        })

        local options = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>fc', vim.lsp.buf.format, options)
    end
}
