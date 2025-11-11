return {
    "christoomey/vim-tmux-navigator",
    "tpope/vim-commentary",
    "tpope/vim-surround",
	config = function()
		vim.g.tmux_navigator_no_wrap = 1
		vim.g.tmux_navigator_preserve_zoom = 1
		vim.g.tmux_navigator_disable_when_zoomed = 1
	end
}
