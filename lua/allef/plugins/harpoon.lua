return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local harpoon = require("harpoon")
        harpoon.setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 40,
            },
        })

        vim.keymap.set("n", "<leader>af", mark.add_file, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fh", ui.toggle_quick_menu, { noremap = true, silent = true })
        vim.keymap.set("n", "<Tab>", ui.nav_next, { noremap = true, silent = true })
        vim.keymap.set("n", "<S-Tab>", ui.nav_prev, { noremap = true, silent = true })
    end,
}
-- return {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = {
--         "nvim-telescope/telescope.nvim",
--         "nvim-lua/plenary.nvim",
--     },
--     config = function()
--         require("telescope").load_extension('harpoon')
--         local harpoon = require("harpoon")
--         harpoon:setup({
--             menu = {
--                 width = vim.api.nvim_win_get_width(0) - 40,
--             }
--         })

--         vim.keymap.set('n', '<leader>af', function() harpoon:list():append() end, { noremap = true, silent = true })
--         vim.keymap.set('n', '<leader>fh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, silent = true })
--         vim.keymap.set('n', '<Tab>', function() harpoon:list():next({ ui_nav_wrap = true }) end, { noremap = true, silent = true })
--         vim.keymap.set('n', '<S-Tab>', function() harpoon:list():prev({ ui_nav_wrap = true }) end, { noremap = true, silent = true })
--     end
-- }
