local status, autopairs = pcall(require, 'nvim-autopairs')
if not status then return end
local status2, autotag = pcall(require, 'nvim-ts-autotag')
if not status2 then return end

autopairs.setup = {
  disable_filetype = { 'TelescopePrompt', 'vim' }
}

autotag.setup = {}
