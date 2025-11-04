local M = {}

-- Custom nvim-cmp source for file autocomplete when typing @ in markdown files
local source = {}

function source:is_available()
	return vim.bo.filetype == "markdown"
end

function source:get_trigger_characters()
	return { "@" }
end

function source:get_keyword_pattern()
	return [[@[a-zA-Z0-9_./\-]*]]
end

function source:complete(request, callback)
	local line = request.context.cursor_line
	local col = request.context.cursor.col

	-- Check if we're at @ trigger
	local before_cursor = line:sub(1, col)
	local match = before_cursor:match("@([^%s]*)$")

	if not match then
		callback({ items = {}, isIncomplete = false })
		return
	end

	-- Get current working directory
	local cwd = vim.fn.getcwd()

	-- Find all files recursively, excluding common ignore patterns
	local items = {}
	local seen_files = {}                                     -- Track files to avoid duplicates

	self:scan_directory(cwd, "", items, match, 0, 3, seen_files) -- max depth of 3

	callback({
		items = items,
		isIncomplete = false,
	})
end

function source:scan_directory(base_path, relative_path, items, filter, depth, max_depth, seen_files)
	if depth > max_depth then
		return
	end

	local full_path = base_path
	if relative_path ~= "" then
		full_path = base_path .. "/" .. relative_path
	end

	local handle = vim.loop.fs_scandir(full_path)
	if not handle then
		return
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then
			break
		end

		-- Skip hidden files and common ignore patterns
		if
			not name:match("^%.")
			and not name:match("^node_modules$")
			and not name:match("^%.git$")
			and not name:match("^target$")
			and not name:match("^build$")
			and not name:match("^dist$")
			and not name:match("^%.DS_Store$")
		then
			local item_relative_path = relative_path == "" and name or (relative_path .. "/" .. name)

			if type == "file" then
				-- Skip if already seen (avoid duplicates)
				if not seen_files[item_relative_path] then
					local score = self:fuzzy_score(filter, name, item_relative_path)
					
					-- Include if filter is empty or has good fuzzy score
					if filter == "" or score > 0 then
						seen_files[item_relative_path] = true
						table.insert(items, {
							label = "@" .. item_relative_path,
							kind = require("cmp").lsp.CompletionItemKind.File,
							insertText = "@" .. item_relative_path,
							detail = "File: " .. item_relative_path,
							documentation = "Insert file path: " .. item_relative_path,
							sortText = string.format("%04d_%04d_%s", 1000 - score, depth, name:lower()),
						})
					end
				end
			elseif type == "directory" then
				-- Recursively scan subdirectories
				self:scan_directory(base_path, item_relative_path, items, filter, depth + 1, max_depth, seen_files)
			end
		end
	end
end

function source:fuzzy_score(filter, name, full_path)
	if filter == "" then
		return 100
	end
	
	local filter_lower = filter:lower()
	local name_lower = name:lower()
	local path_lower = full_path:lower()
	
	-- Exact match gets highest score
	if name_lower == filter_lower then
		return 1000
	end
	
	-- Prefix match gets high score
	if name_lower:sub(1, #filter_lower) == filter_lower then
		return 900
	end
	
	-- Contains match in filename
	if name_lower:find(filter_lower, 1, true) then
		return 800
	end
	
	-- Contains match in full path
	if path_lower:find(filter_lower, 1, true) then
		return 700
	end
	
	-- Fuzzy match - check if all characters of filter appear in order
	local score = 0
	local last_pos = 0
	local consecutive_bonus = 0
	
	for i = 1, #filter_lower do
		local char = filter_lower:sub(i, i)
		local pos = name_lower:find(char, last_pos + 1, true)
		
		if not pos then
			-- Try in full path
			pos = path_lower:find(char, last_pos + 1, true)
			if not pos then
				return 0 -- No fuzzy match
			end
		end
		
		-- Bonus for consecutive characters
		if pos == last_pos + 1 then
			consecutive_bonus = consecutive_bonus + 10
		else
			consecutive_bonus = 0
		end
		
		score = score + 50 + consecutive_bonus
		last_pos = pos
	end
	
	-- Bonus for shorter names (more specific matches)
	local length_bonus = math.max(0, 50 - #name)
	
	return score + length_bonus
end

function M.setup()
	-- Defer setup until nvim-cmp is available
	vim.api.nvim_create_autocmd("User", {
		pattern = "CmpReady",
		callback = function()
			local cmp = require("cmp")
			cmp.register_source("file_autocomplete", source)

			-- Setup cmp for markdown files with our custom source
			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					{ name = "file_autocomplete", priority = 1000 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	})
end

return M
