-- O tema ativo e o "allef-black", definido em colors/allef-black.lua (nao
-- depende de plugin). Ele e aplicado no init.lua, apos o lazy carregar.
-- Os temas abaixo ficam instalados como alternativas, mas inativos (lazy).
return {
	{ "xiantang/darcula-dark.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "blazkowolf/gruber-darker.nvim", lazy = true },
}
