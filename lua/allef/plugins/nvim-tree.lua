return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvim_tree = require("nvim-tree")

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true

        nvim_tree.setup({
            view = {
                width = 40,
                side = "left",
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
                custom = {"^\\.git", "^\\.next", "^node_modules", "^\\.turbo", "^dist"}, -- Toggle with U
            },
        })

        -- vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')
    end
}
