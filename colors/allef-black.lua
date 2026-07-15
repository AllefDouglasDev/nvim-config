-- allef-black: tema pessoal minimalista
-- Fundo preto puro, keywords amarelas, strings verdes, resto branco, comentarios cinza.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "allef-black"

local c = {
	bg = "#000000",
	fg = "#E6E6E6",
	yellow = "#FFCC66",
	green = "#8FBF7F",
	gray = "#5C6370",
	cline = "#121212",
	sel = "#2A2A2A",
	dim = "#3A3A3A",
	-- diagnostics
	red = "#E06C75",
	blue = "#61AFEF",
}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- UI / editor
-- ============================================================================
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg })
hl("FloatBorder", { fg = c.dim, bg = c.bg })
hl("FloatTitle", { fg = c.yellow, bg = c.bg, bold = true })

hl("LineNr", { fg = c.dim })
hl("CursorLineNr", { fg = c.yellow, bold = true })
hl("CursorLine", { bg = c.cline })
hl("CursorColumn", { bg = c.cline })
hl("ColorColumn", { bg = c.cline })

hl("Visual", { bg = c.sel })
hl("VisualNOS", { bg = c.sel })

hl("Search", { fg = c.bg, bg = c.yellow })
hl("IncSearch", { fg = c.bg, bg = c.yellow })
hl("CurSearch", { fg = c.bg, bg = c.yellow })

hl("StatusLine", { fg = c.fg, bg = c.cline })
hl("StatusLineNC", { fg = c.gray, bg = c.cline })
hl("WinSeparator", { fg = c.dim, bg = c.bg })
hl("VertSplit", { fg = c.dim, bg = c.bg })
hl("SignColumn", { fg = c.fg, bg = c.bg })
hl("FoldColumn", { fg = c.dim, bg = c.bg })
hl("Folded", { fg = c.gray, bg = c.cline })

hl("Pmenu", { fg = c.fg, bg = c.cline })
hl("PmenuSel", { fg = c.bg, bg = c.yellow })
hl("PmenuSbar", { bg = c.cline })
hl("PmenuThumb", { bg = c.dim })

hl("NonText", { fg = c.dim })
hl("Whitespace", { fg = c.dim })
hl("EndOfBuffer", { fg = c.bg })
hl("SpecialKey", { fg = c.dim })

hl("Cursor", { fg = c.bg, bg = c.fg })
hl("MatchParen", { fg = c.yellow, bold = true })
hl("Directory", { fg = c.fg })
hl("Title", { fg = c.yellow, bold = true })
hl("WinBar", { fg = c.fg, bg = c.bg })
hl("WinBarNC", { fg = c.gray, bg = c.bg })

-- ============================================================================
-- Sintaxe classica (fallback)
-- ============================================================================
-- amarelo (keywords / reservadas)
hl("Statement", { fg = c.yellow })
hl("Keyword", { fg = c.yellow })
hl("Conditional", { fg = c.yellow })
hl("Repeat", { fg = c.yellow })
hl("Label", { fg = c.yellow })
hl("Exception", { fg = c.yellow })
hl("StorageClass", { fg = c.yellow })
hl("Structure", { fg = c.yellow })
hl("Operator", { fg = c.fg })

-- branco (identificadores / funcoes / tipos / numeros)
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.fg })
hl("Type", { fg = c.fg })
hl("Constant", { fg = c.fg })
hl("Number", { fg = c.fg })
hl("Boolean", { fg = c.fg })
hl("Float", { fg = c.fg })
hl("PreProc", { fg = c.fg })
hl("Include", { fg = c.yellow })
hl("Define", { fg = c.yellow })
hl("Macro", { fg = c.fg })

-- verde (strings)
hl("String", { fg = c.green })
hl("Character", { fg = c.green })

-- cinza (comentarios)
hl("Comment", { fg = c.gray, italic = true })
hl("SpecialComment", { fg = c.gray, italic = true })

-- especiais
hl("Special", { fg = c.fg })
hl("SpecialChar", { fg = c.green })
hl("Delimiter", { fg = c.fg })
hl("Tag", { fg = c.yellow })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })

-- ============================================================================
-- Treesitter (@capture) — principal, ja que TS esta ativo
-- ============================================================================
-- amarelo: keywords / reservadas
hl("@keyword", { fg = c.yellow })
hl("@keyword.function", { fg = c.yellow })
hl("@keyword.return", { fg = c.yellow })
hl("@keyword.operator", { fg = c.yellow })
hl("@keyword.conditional", { fg = c.yellow })
hl("@keyword.repeat", { fg = c.yellow })
hl("@keyword.import", { fg = c.yellow })
hl("@keyword.export", { fg = c.yellow })
hl("@keyword.exception", { fg = c.yellow })
hl("@keyword.storage", { fg = c.yellow })
hl("@keyword.coroutine", { fg = c.yellow })
hl("@conditional", { fg = c.yellow })
hl("@repeat", { fg = c.yellow })
hl("@include", { fg = c.yellow })
hl("@exception", { fg = c.yellow })
hl("@type.qualifier", { fg = c.yellow })

-- branco: variaveis / funcoes / tipos / numeros / operadores / pontuacao
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.fg })
hl("@variable.member", { fg = c.fg })
hl("@variable.parameter", { fg = c.fg })
hl("@field", { fg = c.fg })
hl("@property", { fg = c.fg })
hl("@parameter", { fg = c.fg })
hl("@function", { fg = c.fg })
hl("@function.call", { fg = c.fg })
hl("@function.builtin", { fg = c.fg })
hl("@function.method", { fg = c.fg })
hl("@function.method.call", { fg = c.fg })
hl("@constructor", { fg = c.fg })
hl("@type", { fg = c.fg })
hl("@type.builtin", { fg = c.fg })
hl("@namespace", { fg = c.fg })
hl("@module", { fg = c.fg })
hl("@constant", { fg = c.fg })
hl("@constant.builtin", { fg = c.fg })
hl("@number", { fg = c.fg })
hl("@boolean", { fg = c.fg })
hl("@float", { fg = c.fg })
hl("@operator", { fg = c.fg })
hl("@punctuation.bracket", { fg = c.fg })
hl("@punctuation.delimiter", { fg = c.fg })
hl("@punctuation.special", { fg = c.fg })
hl("@label", { fg = c.yellow })
hl("@attribute", { fg = c.fg })
hl("@tag", { fg = c.yellow })
hl("@tag.attribute", { fg = c.fg })
hl("@tag.delimiter", { fg = c.fg })

-- verde: strings
hl("@string", { fg = c.green })
hl("@string.escape", { fg = c.green })
hl("@string.special", { fg = c.green })
hl("@string.regexp", { fg = c.green })
hl("@character", { fg = c.green })

-- cinza: comentarios
hl("@comment", { fg = c.gray, italic = true })
hl("@comment.documentation", { fg = c.gray, italic = true })

-- ============================================================================
-- LSP semantic tokens (alinha com o resto)
-- ============================================================================
hl("@lsp.type.keyword", { fg = c.yellow })
hl("@lsp.type.variable", { fg = c.fg })
hl("@lsp.type.parameter", { fg = c.fg })
hl("@lsp.type.property", { fg = c.fg })
hl("@lsp.type.function", { fg = c.fg })
hl("@lsp.type.method", { fg = c.fg })
hl("@lsp.type.class", { fg = c.fg })
hl("@lsp.type.type", { fg = c.fg })
hl("@lsp.type.namespace", { fg = c.fg })
hl("@lsp.type.string", { fg = c.green })
hl("@lsp.type.comment", { fg = c.gray, italic = true })

-- ============================================================================
-- Diagnostics (LSP)
-- ============================================================================
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.green })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })

-- ============================================================================
-- Diff / git
-- ============================================================================
hl("DiffAdd", { fg = c.green, bg = c.bg })
hl("DiffChange", { fg = c.yellow, bg = c.bg })
hl("DiffDelete", { fg = c.red, bg = c.bg })
hl("DiffText", { fg = c.yellow, bg = c.cline })
