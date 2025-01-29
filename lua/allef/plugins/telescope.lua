return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        local fb_actions = telescope.extensions.file_browser.actions

        function Telescope_buffer_dir()
            return vim.fn.expand('%:p:h')
        end

        telescope.setup {
            defaults = {
                mappings = {
                    n = {
                        ['q'] =  actions.close
                    }
                },
                file_ignore_patterns = {"vendor", "node_modules", ".git", "target", ".venv", "dist", "pgdata"}
            },
            extensions = {
                fzf = {},
                file_browser = {
                    theme = 'dropdown',
                    hijack_netrw = true,
                    mappings = {
                        ['i'] = {
                            ['N'] = fb_actions.create,
                        },
                        ['n'] = {
                            ['N'] = fb_actions.create,
                            ['h'] = fb_actions.goto_parent_dir,
                            ['r'] = fb_actions.rename,
                            ['<leader>ff'] = actions.close,
                            ['/'] = function()
                                vim.cmd('startinsert')
                            end
                        }
                    }
                }
            }
        }

        telescope.load_extension('fzf')
        telescope.load_extension('file_browser')

        local options = { noremap = true, silent = true }
        vim.keymap.set('n', '<C-p>', '<Cmd>lua require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true, hidden = true, previewer = false })<CR>', options)
        vim.keymap.set('n', '<leader>p', '<Cmd>lua require("telescope.builtin").find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })<CR>', options)
        vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', options)
        vim.keymap.set('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', options)
        vim.keymap.set('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', options)
        vim.keymap.set('n', '<leader>fq', '<Cmd>Telescope quickfix<CR>', options)
        vim.keymap.set('n', '<leader>ff', '<Cmd>lua require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", cwd = Telescope_buffer_dir(), respoect_git_ignore = false, hidden = true, grouped = true, initial_mode = "normal" })<CR>', options)
    end
}
