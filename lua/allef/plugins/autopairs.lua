return {
    "windwp/nvim-autopairs",
    dependencies = {
        "alvan/vim-closetag",
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local autopairs = require("nvim-autopairs")
        local ts_autotag = require("nvim-ts-autotag")

        autopairs.setup({
            disable_filetype = { "TelescopePrompt", "vim" },
        })
        ts_autotag.setup()
    end,
}
