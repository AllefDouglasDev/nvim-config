return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        local parsers = {
            "css",
            "html",
            "http",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "prisma",
            "python",
            "query",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "go",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match
                if not lang or lang == "" then
                    return
                end
                local ok = pcall(vim.treesitter.start, args.buf, lang)
                if ok then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
