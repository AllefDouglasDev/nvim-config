--[[
  nvim-cmp: Autocompletion plugin

  Sources (in priority order):
  1. nvim_lsp - LSP completions
  2. path - File paths
  3. buffer - Words from current buffer

  Keymaps:
  - <C-Space> - Trigger completion
  - <CR> - Confirm selection
  - <C-e> - Abort completion
  - <Tab>/<S-Tab> - Navigate items
  - <C-b>/<C-f> - Scroll docs
]]

-- Icons for completion items
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        -- Completion sources
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        -- Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Load friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -----------------------------------------
        -- Completion Options
        -----------------------------------------
        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        -----------------------------------------
        -- Helper: Check if there's a word before cursor
        -----------------------------------------
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -----------------------------------------
        -- Main Setup
        -----------------------------------------
        cmp.setup({
            -- Snippet engine (required)
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Window appearance
            window = {
                completion = cmp.config.window.bordered({
                    scrollbar = true,
                }),
                documentation = cmp.config.window.bordered(),
            },

            -- Key mappings
            mapping = cmp.mapping.preset.insert({
                -- Scroll documentation
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Trigger completion
                ["<C-Space>"] = cmp.mapping.complete(),

                -- Abort completion
                ["<C-e>"] = cmp.mapping.abort(),

                -- Confirm selection (select = false means you must explicitly select)
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- Tab: navigate cmp / expand snippets / fallback to literal Tab.
                -- Codeium suggestions are accepted with <C-g> (see codeium.lua) to
                -- avoid mixing codeium#Accept() (an expr-mapping helper) with
                -- nvim_feedkeys, which caused INSERT-mode hangs.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- Completion sources (in priority order)
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip", priority = 750 },
                { name = "path", priority = 500 },
            }, {
                { name = "buffer", priority = 250, keyword_length = 3 },
            }),

            -- Formatting
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- Kind icon
                    vim_item.kind = kind_icons[vim_item.kind] or ""

                    -- Source label
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buf]",
                        path = "[Path]",
                    })[entry.source.name]

                    -- Tailwind colors (if available)
                    local ok, tailwind_formatter = pcall(require, "tailwindcss-colorizer-cmp")
                    if ok then
                        return tailwind_formatter.formatter(entry, vim_item)
                    end

                    return vim_item
                end,
            },

            -- Sorting
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        -----------------------------------------
        -- Filetype-specific setup
        -----------------------------------------
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "buffer" },
            }),
        })

        -----------------------------------------
        -- Cmdline setup
        -----------------------------------------
        -- Search (/)
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Command mode (:)
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        -- Emit ready event
        vim.api.nvim_exec_autocmds("User", { pattern = "CmpReady" })
    end,
}
