--[[
  flutter-tools.nvim: Dart + Flutter support

  Handles everything Dart/Flutter related:
  - dartls LSP (comes with the Dart SDK, so it is NOT installed via Mason)
  - Hot reload / hot restart, device and emulator pickers
  - Widget guides, closing tags and the outline window
  - DAP adapters for both plain Dart and Flutter apps

  Requires the Flutter SDK on PATH (`cask "flutter"` in install/Brewfile).

  Keymaps (Flutter prefix: <leader>F):
  - <leader>Fr  Run the app
  - <leader>Fl  Hot reload
  - <leader>FR  Hot restart
  - <leader>Fq  Quit the running app
  - <leader>Fd  Pick device
  - <leader>Fe  Pick emulator
  - <leader>Fo  Toggle the widget outline
  - <leader>Fv  Open DevTools
  - <leader>Fc  Clear the dev log
  - <leader>Fs  Telescope: all Flutter commands
]]

return {
    "nvim-flutter/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "mfussenegger/nvim-dap",
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { "<leader>Fr", "<Cmd>FlutterRun<CR>", desc = "Flutter: run" },
        { "<leader>Fl", "<Cmd>FlutterReload<CR>", desc = "Flutter: hot reload" },
        { "<leader>FR", "<Cmd>FlutterRestart<CR>", desc = "Flutter: hot restart" },
        { "<leader>Fq", "<Cmd>FlutterQuit<CR>", desc = "Flutter: quit app" },
        { "<leader>Fd", "<Cmd>FlutterDevices<CR>", desc = "Flutter: devices" },
        { "<leader>Fe", "<Cmd>FlutterEmulators<CR>", desc = "Flutter: emulators" },
        { "<leader>Fo", "<Cmd>FlutterOutlineToggle<CR>", desc = "Flutter: toggle outline" },
        { "<leader>Fv", "<Cmd>FlutterDevTools<CR>", desc = "Flutter: DevTools" },
        { "<leader>Fc", "<Cmd>FlutterLogClear<CR>", desc = "Flutter: clear dev log" },
        { "<leader>Fs", "<Cmd>Telescope flutter commands<CR>", desc = "Flutter: commands" },
    },
    config = function()
        -----------------------------------------
        -- LSP Capabilities (from nvim-cmp)
        --
        -- flutter-tools starts dartls on its own, so it does not go through
        -- the `vim.lsp.config("*", ...)` defaults set in plugins/lsp.lua.
        -----------------------------------------
        local capabilities
        local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok then
            capabilities = cmp_nvim_lsp.default_capabilities()
        end

        require("flutter-tools").setup({
            ui = {
                border = "rounded",
                notification_style = "native",
            },
            decorations = {
                statusline = {
                    app_version = true,
                    device = true,
                    project_config = true,
                },
            },
            widget_guides = { enabled = true },
            closing_tags = {
                enabled = true,
                highlight = "Comment",
                prefix = "// ",
            },
            dev_log = {
                enabled = true,
                open_cmd = "botright 15split",
            },
            dev_tools = {
                autostart = false,
                auto_open_browser = false,
            },
            outline = {
                open_cmd = "30vnew",
                auto_open = false,
            },

            -----------------------------------------
            -- dartls
            -----------------------------------------
            lsp = {
                capabilities = capabilities,
                -- Colors are not handled here: `lsp.color` is deprecated on
                -- Neovim 0.12+, and nvim-colorizer (plugins/tailwind.lua) already
                -- turns core's vim.lsp.document_color off to draw its own ■.
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    enableSnippets = true,
                    updateImportsOnRename = true,
                    renameFilesWithClasses = "prompt",
                    -- analysisExcludedFolders is left alone on purpose: settings
                    -- are merged with tbl_deep_extend("force"), so setting it here
                    -- would drop the SDK paths flutter-tools already excludes.
                },
            },

            -----------------------------------------
            -- Debugging (nvim-dap)
            -----------------------------------------
            debugger = {
                enabled = true,
                run_via_dap = true,
                exception_breakpoints = {},
                -- Runs right after flutter-tools registers its own launch/attach
                -- configs, so only add to them: replacing the table would drop
                -- the project-aware defaults (Flutter vs plain Dart entrypoint).
                register_configurations = function(_)
                    pcall(function()
                        require("dap.ext.vscode").load_launchjs(nil, { dart = { "dart" } })
                    end)
                end,
            },
        })

        pcall(require("telescope").load_extension, "flutter")
    end,
}
