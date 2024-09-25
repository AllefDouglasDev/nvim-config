return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        -- 'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        require("nvim-ts-autotag").setup()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = {
                enable = true,
                disable = {},
            },
            ensure_installed = {
                "css",
                "http",
                "json",
                "lua",
                "prisma",
                "query",
                "rust",
                "toml",
                "tsx",
                "typescript",
            },
        })
    end,
}
