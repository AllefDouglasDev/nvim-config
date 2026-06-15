--[[
  LSP Configuration

  This file configures:
  - Mason (LSP/tools installer)
  - Diagnostics appearance
  - LSP keymaps (buffer-local via LspAttach)
  - ESLint auto-fix on save

  Keymaps (available when LSP attaches):
  - gd         Go to definition
  - gr         Go to references
  - gi         Go to implementation
  - K          Hover documentation
  - <leader>rn Rename symbol
  - <leader>x  Show diagnostics float
  - ac         Code actions
  - [d / ]d    Previous/Next diagnostic
]]

-----------------------------------------
-- LSP Servers to install
-----------------------------------------
local servers = {
    "ts_ls",
    "eslint",
    "lua_ls",
    "cssls",
    "tailwindcss",
    "gopls",
    "rust_analyzer",
    "clangd",
    "pylsp",
    "prismals",
    "marksman",
    "jdtls",
	"zls",
}

-----------------------------------------
-- Tools to install (formatters/linters)
-----------------------------------------
local tools = {
    "prettier",
    "prettierd",
    "stylua",
}

-----------------------------------------
-- Diagnostic signs
-----------------------------------------
local diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "✗",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.HINT] = "",
    [vim.diagnostic.severity.INFO] = "",
}


return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -----------------------------------------
        -- Mason Setup
        -----------------------------------------
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_enable = true,
        })

        require("mason-tool-installer").setup({
            ensure_installed = tools,
        })

        -----------------------------------------
        -- LSP Capabilities (from nvim-cmp)
        -----------------------------------------
        local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok then
            vim.lsp.config("*", {
                capabilities = cmp_nvim_lsp.default_capabilities(),
            })
        end

        -----------------------------------------
        -- Java: jdtls requires JDK 21+, but /usr/bin/java points to JDK 20.
        -- Point JAVA_HOME at Homebrew's newer OpenJDK so the jdtls launcher uses it.
        -----------------------------------------
        local jdk_home = "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
        if vim.fn.isdirectory(jdk_home) == 1 then
            vim.env.JAVA_HOME = jdk_home
        end

        -----------------------------------------
        -- Enable LSP Servers
        -----------------------------------------
        vim.lsp.enable(servers)

        -----------------------------------------
        -- Diagnostics Configuration
        -----------------------------------------
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 2,
            },
            signs = {
                text = diagnostic_signs,
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })

        -----------------------------------------
        -- LSP Keymaps (buffer-local)
        -----------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Navigation
                vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
                vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

                -- Documentation
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

                -- Refactoring
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "ac", vim.lsp.buf.code_action, opts)

                -- Diagnostics
                vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                vim.keymap.set("n", "<leader>df", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
                vim.keymap.set("n", "<leader>sd", "<Cmd>Telescope diagnostics<CR>", opts)

                -- Workspace
                vim.keymap.set("n", "<leader>ws", "<Cmd>Telescope lsp_workspace_symbols<CR>", opts)
            end,
        })

        -----------------------------------------
        -- ESLint: Auto-fix on save
        -----------------------------------------
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("EslintAutoFix", { clear = true }),
            pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue", "*.svelte" },
            callback = function()
                -- Only run if ESLint is attached and command exists
                local clients = vim.lsp.get_clients({ bufnr = 0, name = "eslint" })
                if #clients > 0 and vim.fn.exists(":EslintFixAll") > 0 then
                    vim.cmd("EslintFixAll")
                end
            end,
        })

        -----------------------------------------
        -- Floating window borders (Neovim 0.11+)
        -----------------------------------------
        vim.o.winborder = "rounded"

        -----------------------------------------
        -- Global keymaps (non-LSP)
        -----------------------------------------
        vim.keymap.set("n", "<leader>rt", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
            desc = "Replace word under cursor",
        })
    end,
}
