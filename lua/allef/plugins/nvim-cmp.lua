return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require('cmp')
        local luasnip_from_vscode = require("luasnip/loaders/from_vscode")
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local nvim_lsp = require('lspconfig')
        local luasnip = require('luasnip')

        luasnip_from_vscode.lazy_load()

        vim.opt.completeopt = "menu,menuone,noselect"

        local kind_icons = {
            Text = "",
            Method = "m",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = { -- rounded border; thin-style scrollbar
                    border = 'rounded',
                    scrollbar = '║',
                },
                documentation = {
                    border = 'rounded',
                    scrollbar = '',
                },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            }, {
                    { name = 'buffer' },
                }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "",
                        luasnip = "",
                        buffer = "",
                        path = "",
                    })[entry.source.name]
                    return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                    -- return vim_item
                end,
            },
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                    { name = 'buffer' },
                })
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        nvim_lsp.ts_ls.setup {
            capabilities = capabilities,
            filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
            root_dir = function() return vim.loop.cwd() end,
        }
        nvim_lsp.prismals.setup {
            capabilities = capabilities
        }
        nvim_lsp.rust_analyzer.setup {
            capabilities = capabilities
        }
        nvim_lsp.cssls.setup {
            capabilities = capabilities
        }
        nvim_lsp.csharp_ls.setup {
            capabilities = capabilities
        }
        nvim_lsp.gopls.setup {
            capabilities = capabilities
        }
        nvim_lsp.jdtls.setup {
            capabilities = capabilities
        }
        nvim_lsp.gdscript.setup {
            capabilities = capabilities
        }
        nvim_lsp.lua_ls.setup {
            capabilities = capabilities
        }
        nvim_lsp.clangd.setup {
            capabilities = capabilities
        }
        nvim_lsp.pyright.setup {
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        extraPaths = {
                            "/Users/allefdouglascruz/Documents/dev/joyjet/alta-backend/.venv/lib/python2.7/site-packages",
                        }
                    }
                }
            }
        }
    end
}
