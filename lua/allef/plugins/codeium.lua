return {
    "Exafunction/codeium.vim",
    config = function ()
        -- Disable default Tab mapping so we can handle it in nvim-cmp
        vim.g.codeium_no_map_tab = true

        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
        vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        vim.keymap.set('n', '<leader>dia', '<Cmd>CodeiumDisable<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>eia', '<Cmd>CodeiumEnable<CR>', { noremap = true, silent = true })

        -- disable by default
        -- vim.cmd('CodeiumDisable')
    end
}
