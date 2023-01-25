local lsp = require ("lspconfig")

local on_attach = function(client, bufnr)
  require("tailwindcss-colors").buf_attach(bufnr)
end

lsp.tailwindcss.setup{
  settings = {
    scss = { validate = false },
    editor = {
      quickSuggestions = { strings = true },
      autoClosingQuotes = 'always',
    },
    tailwindCSS = {
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

