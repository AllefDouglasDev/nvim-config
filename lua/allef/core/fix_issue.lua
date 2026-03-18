--[[
  Quick Fix: Applies the first available code action for the current line

  Keymap: qf
]]

local function apply_action(action, client)
    if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end

    if action.command then
        local command = type(action.command) == "table" and action.command or action
        client.request("workspace/executeCommand", command, function(err)
            if err then
                vim.notify("Command failed: " .. (err.message or "unknown error"), vim.log.levels.WARN)
            end
        end, 0)
    end
end

local function resolve_and_apply(action, client)
    -- If the action needs to be resolved first
    if
        not action.edit
        and client.server_capabilities.codeActionProvider
        and type(client.server_capabilities.codeActionProvider) == "table"
        and client.server_capabilities.codeActionProvider.resolveProvider
    then
        client.request("codeAction/resolve", action, function(err, resolved)
            if err then
                vim.notify("Resolve failed: " .. (err.message or "unknown"), vim.log.levels.WARN)
                return
            end
            apply_action(resolved or action, client)
        end, 0)
    else
        apply_action(action, client)
    end
end

-- Check if action is likely to work
local function is_valid_action(action)
    local title = action.title or ""

    -- Skip problematic TypeScript actions
    if title:match("[Mm]ove to a? ?new file") then
        return false
    end

    -- Prefer actions with edits (more reliable)
    if action.edit then
        return true
    end

    -- Skip actions that only have typescript-specific commands
    if action.command and type(action.command) == "table" then
        local cmd = action.command.command or ""
        if cmd:match("^_typescript") then
            return false
        end
    end

    return true
end

-- Check if action looks like a fix
local function is_fix_action(title)
    return title:match("[Ff]ix")
        or title:match("[Aa]utofix")
        or title:match("[Ss]ort")
        or title:match("[Rr]emove unused")
        or title:match("[Aa]dd missing")
        or title:match("[Ii]mport")
        or title:match("[Uu]pdate import")
        or title:match("[Dd]isable")
end

local function fix()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        vim.notify("No LSP client attached!", vim.log.levels.WARN)
        return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor[1] - 1 })

    -- Convert diagnostics to LSP format
    local lsp_diagnostics = {}
    for _, diag in ipairs(line_diagnostics) do
        table.insert(lsp_diagnostics, {
            range = {
                start = { line = diag.lnum, character = diag.col },
                ["end"] = { line = diag.end_lnum or diag.lnum, character = diag.end_col or diag.col },
            },
            message = diag.message,
            severity = diag.severity,
            source = diag.source,
        })
    end

    -- Try each client
    for _, client in ipairs(clients) do
        local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
        params.context = { diagnostics = lsp_diagnostics }

        local result = client.request_sync("textDocument/codeAction", params, 2000, bufnr)

        if result and result.result and #result.result > 0 then
            local actions = result.result

            -- First pass: look for fix actions with edits
            for _, action in ipairs(actions) do
                if is_valid_action(action) and action.edit and is_fix_action(action.title or "") then
                    resolve_and_apply(action, client)
                    return
                end
            end

            -- Second pass: any fix action
            for _, action in ipairs(actions) do
                if is_valid_action(action) and is_fix_action(action.title or "") then
                    resolve_and_apply(action, client)
                    return
                end
            end

            -- Third pass: any valid action with edit
            for _, action in ipairs(actions) do
                if is_valid_action(action) and action.edit then
                    resolve_and_apply(action, client)
                    return
                end
            end

            -- Last resort: first valid action
            for _, action in ipairs(actions) do
                if is_valid_action(action) then
                    resolve_and_apply(action, client)
                    return
                end
            end
        end
    end

    vim.notify("No code actions available!", vim.log.levels.INFO)
end

-- Keymaps
vim.keymap.set("n", "qf", fix, { noremap = true, silent = true, desc = "Apply quickfix" })
vim.keymap.set("v", "qf", fix, { noremap = true, silent = true, desc = "Apply quickfix" })
