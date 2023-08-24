local cmp = require'cmp'

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = { -- rounded border; thin-style scrollbar
      border = 'rounded',
      scrollbar = '║',
    },
    documentation = {
      border = 'rounded',
      scrollbar = '',
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
        path = "(Path)",
      })[entry.source.name]
      return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
      -- return vim_item
    end,
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end,
}
nvim_lsp.prismals.setup {
  capabilities = capabilities
}
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities
}
nvim_lsp.cssls.setup {
  capabilities = capabilities
}
nvim_lsp.csharp_ls.setup {
  capabilities = capabilities
}
nvim_lsp.gopls.setup {
  capabilities = capabilities
}

