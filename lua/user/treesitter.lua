require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = { 'tsx', 'lua', 'json', 'css' },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- local autocomplete_twin_macro = function()
--   print('called')
--   local css_expression = vim.treesitter.parse_query(
--     "typescript",
--     [[
-- (call_expression
--   function: (identifier) @func (#eq? @func "tw")
--   arguments: (template_string) @args
-- ) @call
-- ]]
--   )
--   local parser = vim.treesitter.get_parser(0, "typescript")
--   local root = parser:parse()[1]:root()
--   local bufnr = vim.api.nvim_get_current_buf()
--   for id, node in css_expression:iter_captures(root, bufnr, 0, -1) do
--     local name = css_expression.captures[id]
--     if name == "args" then
--       -- local range = { node:range() }  
--       local content = vim.treesitter.get_node_text(node, bufnr)
--       print(content)
--       vim.lsp.buf_notify(bufnr, '', )
--     end
--   end
-- end

-- local options = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>.', autocomplete_twin_macro, options)
-- vim.keymap.set('i', '<C-e>', autocomplete_twin_macro, options)

