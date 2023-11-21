function write_mode()
    require('cmp').setup.buffer { enabled = false }
    vim.cmd([[ CodeiumDisable ]])
    vim.opt.background = "light"
    vim.cmd([[ colorscheme quiet ]])
end
