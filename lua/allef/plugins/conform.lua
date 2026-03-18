--[[
  conform.nvim: Formatter plugin

  Formatters by language:
  - Lua: stylua
  - JS/TS/React: prettierd (fallback: prettier)
  - CSS/SCSS/Less: prettierd
  - JSON/HTML/Markdown: prettierd

  Keymaps:
  - <leader>fc  Format buffer (manual)
]]

-----------------------------------------
-- Formatters by filetype
-----------------------------------------
local formatters_by_ft = {
    lua = { "stylua" },

    -- JavaScript/TypeScript
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },

    -- Web
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    less = { "prettierd", "prettier", stop_after_first = true },

    -- Data
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },

    -- GraphQL
    graphql = { "prettierd", "prettier", stop_after_first = true },
}

return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fc",
            function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = formatters_by_ft,
        notify_on_error = true,
    },
}
