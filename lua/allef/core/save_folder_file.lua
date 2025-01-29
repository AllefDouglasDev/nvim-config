local M = {}

-- Function to create directory and save current file if they don't exist
function M.save_folder_file()
	-- Get the current buffer's file path
	local current_file = vim.fn.expand("%")

	-- Check if the file exists
	if current_file == "" then
		return
	end

	-- Create the directory structure and save the file
	vim.cmd([[:!mkdir -p %:h]])
	vim.cmd([[:w]])
end

-- Create a command to call the function
vim.api.nvim_create_user_command("SaveFolderFile", function()
	M.save_folder_file()
end, {})

return M
