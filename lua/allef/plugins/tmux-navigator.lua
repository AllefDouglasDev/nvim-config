return {
    "christoomey/vim-tmux-navigator",
    priority = 1000,
    lazy = false,
    init = function()
        vim.g.tmux_navigator_no_wrap = 1
        vim.g.tmux_navigator_preserve_zoom = 1
        vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
    config = function()
        -- Keymaps definidos após VimEnter para garantir que não sejam sobrescritos
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
                vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
                vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
                vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
            end,
        })
    end,
}
