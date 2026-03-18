return {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    dependencies = {
        "NvChad/nvim-colorizer.lua",
    },
    config = function()
        require("colorizer").setup({
            user_default_options = {
                mode = "virtualtext",
                virtualtext = "■",
                tailwind = true,
            },
        })

        require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
        })
    end,
}
