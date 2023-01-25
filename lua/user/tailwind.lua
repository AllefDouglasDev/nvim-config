local lsp = require ("lspconfig")

local on_attach = function(client, bufnr)
  require("tailwindcss-colors").buf_attach(bufnr)
end

print(lsp.tailwindcss)

lsp.tailwindcss.setup{
  settings = {
    scss = { validate = false },
    editor = {
      quickSuggestions = { strings = true },
      autoClosingQuotes = 'always',
    },
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      experimental = {
        classRegex = {
          'tw`([^`]*)', -- tw`...`
          'tw="([^"]*)', -- <div tw="..." />
          'tw={"([^"}]*)', -- <div tw={"..."} />
          'tw\\.\\w+`([^`]*)', -- tw.xxx`...`
          'tw\\(.*?\\)`([^`]*)', -- tw(Component)`...`
        },
      },
      includeLanguages = {
        typescript = 'javascript',
        typescriptreact = 'javascript',
      },
    },
  },
  on_attach = on_attach
}

require("tailwindcss-colorizer-cmp").setup({
  color_square_width = 2,
})

require("cmp").config.formatting = {
  format = require("tailwindcss-colorizer-cmp").formatter
}

