return {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    dependencies = {
        "NvChad/nvim-colorizer.lua",
        {
            "themaxmarchuk/tailwindcss-colors.nvim",
            module = "tailwindcss-colors",
        }
    },
    config = function()
        local lsp = require("lspconfig")
        local colorizer = require("colorizer") 
        local tailwindCssColors = require("tailwindcss-colors")
        local tailwind_colorizer_cmp = require("tailwindcss-colorizer-cmp")

        colorizer.setup({
            user_default_options = {
                mode = "virtualtext",
                virtualtext = "■",
                tailwind = true,
            }
        })

        local on_attach = function(client, bufnr)
            tailwindCssColors.buf_attach(bufnr)
        end

        lsp.tailwindcss.setup{
            settings = {
                scss = { validate = false },
                editor = {
                    quickSuggestions = { strings = true },
                    autoClosingQuotes = 'always',
                },
                tailwindCSS = {
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
                            -- 'tw`([^`]*)', -- tw`...`
                            -- 'tw="([^"]*)', -- <div tw="..." />
                            -- 'tw={"([^"}]*)', -- <div tw={"..."} />
                            -- 'tw\\.\\w+`([^`]*)', -- tw.xxx`...`
                            -- 'tw\\(.*?\\)`([^`]*)', -- tw(Component)`...`
                            "cva\\(([^)]*)\\)",
                            "cn\\(\"([^\\\"]*)\"\\)", -- cn("...")
                            "cn\\('([^\\']*)'\\)", -- cn('...')
                            "ClassName\\('([^\\']*)'\\)", -- cn('...')
                            -- "[\"'`]([^\"'`]*).*?[\"'`]",
                        }
                    },
                    includeLanguages = {
                        typescript = 'javascript',
                        typescriptreact = 'javascript',
                    },
                },
            },
            on_attach = on_attach
        }

        tailwind_colorizer_cmp.setup({ color_square_width = 2 })
    end
}
