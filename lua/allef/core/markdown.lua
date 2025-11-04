local M = {}

local preview_job_id = nil
local temp_file = nil
local timer = nil
local buf_augroup = nil
local debug_mode = false
local real_file_path = nil

function M.debug(enable)
  debug_mode = enable
  vim.notify('Markdown Preview: Debug mode ' .. (enable and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function get_bin_path()
  local md_cmd = vim.fn.exepath('md')
  if md_cmd ~= '' then
    return md_cmd
  end

  local possible_paths = {
    vim.fn.expand('~/Documents/dev/node/markdown/bin/md'),
    '/usr/local/bin/md',
    vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ':h') .. '/../bin/md',
  }

  for _, path in ipairs(possible_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  return 'md'
end

local function create_temp_file()
  local tmpname = vim.fn.tempname() .. '.md'
  return tmpname
end

local function write_buffer_to_file(bufnr, filepath)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

  local metadata = string.format(
    '<!-- nvim-metadata\ncursor-line: %d\nreal-path: %s\n-->',
    cursor_line,
    real_file_path or 'Unsaved buffer'
  )
  local content_with_metadata = metadata .. '\n' .. table.concat(lines, '\n')

  local file = io.open(filepath, 'w')
  if file then
    file:write(content_with_metadata)
    file:close()
    return true
  end
  return false
end

local function setup_auto_update(bufnr, filepath)
  if buf_augroup then
    vim.api.nvim_del_augroup_by_id(buf_augroup)
  end

  buf_augroup = vim.api.nvim_create_augroup('MarkdownPreviewSync', { clear = true })

  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'TextChangedP', 'CursorMoved', 'CursorMovedI' }, {
    group = buf_augroup,
    buffer = bufnr,
    callback = function()
      if timer then
        vim.fn.timer_stop(timer)
      end

      timer = vim.fn.timer_start(300, function()
        write_buffer_to_file(bufnr, filepath)
      end)
    end,
  })

  vim.api.nvim_create_autocmd('BufDelete', {
    group = buf_augroup,
    buffer = bufnr,
    callback = function()
      M.stop()
    end,
  })
end

function M.start()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if filetype ~= 'markdown' then
    vim.notify('Markdown Preview: Current buffer is not a markdown file', vim.log.levels.WARN)
    return
  end

  if preview_job_id then
    vim.notify('Markdown Preview: Already running', vim.log.levels.INFO)
    return
  end

  real_file_path = vim.api.nvim_buf_get_name(bufnr)
  if real_file_path == '' then
    real_file_path = 'Unsaved buffer'
  end

  temp_file = create_temp_file()

  if not write_buffer_to_file(bufnr, temp_file) then
    vim.notify('Markdown Preview: Failed to create temporary file', vim.log.levels.ERROR)
    return
  end

  local bin_path = get_bin_path()

  if vim.fn.executable(bin_path) ~= 1 then
    vim.notify(
      'Markdown Preview: Command "md" not found. Please run "npm link" in the markdown project directory.',
      vim.log.levels.ERROR
    )
    if temp_file then
      vim.fn.delete(temp_file)
      temp_file = nil
    end
    return
  end

  if debug_mode then
    vim.notify(string.format('Markdown Preview: Executing: %s %s', bin_path, temp_file), vim.log.levels.INFO)
  end

  preview_job_id = vim.fn.jobstart({ bin_path, temp_file }, {
    on_exit = function(_, exit_code, _)
      if debug_mode then
        vim.notify(string.format('Markdown Preview: Command exited with code %d', exit_code), vim.log.levels.INFO)
      end
    end,
  })

  if preview_job_id <= 0 then
    vim.notify('Markdown Preview: Failed to start preview process', vim.log.levels.ERROR)
    preview_job_id = nil
    if temp_file then
      vim.fn.delete(temp_file)
      temp_file = nil
    end
    return
  end

  setup_auto_update(bufnr, temp_file)

  vim.notify('Markdown Preview: Started', vim.log.levels.INFO)
end

function M.stop()
  if timer then
    vim.fn.timer_stop(timer)
    timer = nil
  end

  if buf_augroup then
    vim.api.nvim_del_augroup_by_id(buf_augroup)
    buf_augroup = nil
  end

  preview_job_id = nil

  if temp_file and vim.fn.filereadable(temp_file) == 1 then
    vim.fn.delete(temp_file)
  end
  temp_file = nil

  vim.notify('Markdown Preview: Stopped (close window manually)', vim.log.levels.INFO)
end

function M.toggle()
  if preview_job_id then
    M.stop()
  else
    M.start()
  end
end

function M.setup(opts)
  opts = opts or {}

  local keymap = opts.keymap or '<leader>md'

  vim.keymap.set('n', keymap, function()
    M.toggle()
  end, { desc = 'Toggle Markdown Preview', silent = true })

  vim.api.nvim_create_user_command('MarkdownPreview', M.start, {})
  vim.api.nvim_create_user_command('MarkdownPreviewStop', M.stop, {})
  vim.api.nvim_create_user_command('MarkdownPreviewToggle', M.toggle, {})
  vim.api.nvim_create_user_command('MarkdownPreviewDebug', function(cmd)
    M.debug(cmd.args == 'on' or cmd.args == '1' or cmd.args == 'true')
  end, { nargs = 1 })
end

return M
