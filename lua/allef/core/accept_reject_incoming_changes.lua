local api = vim.api

-- Helper to run a normal mode command
local function normal(cmd)
  api.nvim_feedkeys(api.nvim_replace_termcodes(cmd, true, false, true), 'n', false)
end

-- Accept all incoming changes (theirs)
local function accept_all_incoming()
  vim.cmd('normal! gg')
  while true do
    local prev_pos = api.nvim_win_get_cursor(0)
    vim.cmd('GitConflictNextConflict')
    local new_pos = api.nvim_win_get_cursor(0)
    if prev_pos[1] == new_pos[1] and prev_pos[2] == new_pos[2] then
      break -- No more conflicts
    end
    vim.cmd('GitConflictChooseTheirs')
  end
end

-- Reject all incoming changes (ours)
local function reject_all_incoming()
  vim.cmd('normal! gg')
  while true do
    local prev_pos = api.nvim_win_get_cursor(0)
    vim.cmd('GitConflictNextConflict')
    local new_pos = api.nvim_win_get_cursor(0)
    if prev_pos[1] == new_pos[1] and prev_pos[2] == new_pos[2] then
      break -- No more conflicts
    end
    vim.cmd('GitConflictChooseOurs')
  end
end

-- Register commands
api.nvim_create_user_command('AcceptAllIncoming', accept_all_incoming, {})
api.nvim_create_user_command('RejectAllIncoming', reject_all_incoming, {})

vim.keymap.set('n', '<leader>aai', ':AcceptAllIncoming<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rai', ':RejectAllIncoming<CR>', { noremap = true, silent = true })
