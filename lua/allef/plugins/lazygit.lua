return {
  "kdheepak/lazygit.nvim",
  config = function()
    vim.keymap.set('n', '<leader>m', ':LazyGit<cr>', { noremap = true })
  end
}
