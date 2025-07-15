return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	opts = {
		dir = "~/Documents/dev/notes/",
	},
    config = function(_, opts)
        require("obsidian").setup(opts)
        vim.opt_local.conceallevel = 2
    end
}
