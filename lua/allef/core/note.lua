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

M.create_file = function(name)
	local index_with_pad = string.format("%03d", get_next_index())
	if name == nil then
		vim.cmd("e " .. index_with_pad .. ".md")
	else
		vim.cmd("e " .. index_with_pad .. "-" .. name .. ".md")
	end
end

vim.api.nvim_create_user_command("NCreateFile", function(opts)
	local name = opts.args
	if name == "" then
		name = nil
	end
	M.create_file(name)
end, { nargs = '?' })

return M
