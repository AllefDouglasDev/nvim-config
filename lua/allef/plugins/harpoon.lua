return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").load_extension('harpoon')
        local harpoon = require("harpoon")
        harpoon:setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 40,
            }
        })

        vim.keymap.set('n', '<leader>af', function() harpoon:list():append() end, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>fh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, silent = true })
        vim.keymap.set('n', '<Tab>', function() harpoon:list():next({ ui_nav_wrap = true }) end, { noremap = true, silent = true })
        vim.keymap.set('n', '<S-Tab>', function() harpoon:list():prev({ ui_nav_wrap = true }) end, { noremap = true, silent = true })
    end
}
