local M = {}

M.setup = function() end

local get_file_names = function()
	local path = vim.fn.getcwd()
	local entries = vim.fn.readdir(path)
	local file_names = {}
	if entries then
		for _, entry in ipairs(entries) do
			local full_path = path .. "/" .. entry
			if vim.fn.isdirectory(full_path) == 0 then
				table.insert(file_names, entry)
			end
		end
	end
	return file_names
end

local get_next_index = function()
	local file_names = get_file_names()
	local last_item = file_names[#file_names]
	local index = last_item:match("%d+")
	if index == nil then
		return 1
	end
	return index + 1
end

local capitalize_first = function(str)
	return (string.gsub(str, "^.", string.upper))
end

M.create_file = function(name)
	local index_with_pad = string.format("%03d", get_next_index())
	local file_name = index_with_pad .. ".md"
	local file_lines = { "# ", "", "TAGS: #" }
	if name ~= nil then
		name = name:gsub(" ", "_")
		file_lines = { "# " .. capitalize_first(name), "", "TAGS: #" .. name }
		file_name = index_with_pad .. "_" .. name .. ".md"
	end
	local buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, file_lines)
	vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
	vim.api.nvim_win_set_buf(0, buf)
	vim.api.nvim_buf_set_name(buf, file_name)
end

vim.api.nvim_create_user_command("NotesCreateFile", function(opts)
	local name = opts.args
	if name == "" then
		name = nil
	end
	M.create_file(name)
end, { nargs = '?' })

vim.api.nvim_create_user_command("NotesSearch", function(opts)
	local search = opts.args
	if search == "" or search == nil then
		search = ""
	end
	vim.cmd("vim /" .. search .."/ *.md")
	vim.cmd("copen")
end, { nargs = '?'})

return M
