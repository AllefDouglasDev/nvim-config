return {
    "Exafunction/codeium.vim",
    config = function ()
        vim.env.OPENAI_API_KEY = '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'

        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
        vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
}
