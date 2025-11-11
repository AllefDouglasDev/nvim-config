# Personal Neovim Configuration

## Features

### Core Functionality
- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loading plugin management
- **LSP Integration**: Full Language Server Protocol support with Mason for easy server management
- **Fuzzy Finding**: Telescope for files, buffers, grep, and more
- **Smart Completion**: nvim-cmp with multiple sources (LSP, buffer, path, snippets)
- **Syntax Highlighting**: Treesitter for advanced syntax highlighting and code understanding
- **Git Integration**: Gitsigns for inline git information and custom conflict resolution
- **Debugging**: nvim-dap for Debug Adapter Protocol support

### Language Support
Pre-configured LSP servers for:
- TypeScript/JavaScript (ts_ls)
- Rust (rust_analyzer)
- Go (gopls)
- Python (pylsp)
- C/C++ (clangd)
- Lua (lua_ls)
- CSS (cssls)
- C# (csharp_ls)
- Java (jdtls)
- Prisma (prismals)
- Markdown (marksman)
- GDScript (gdscript)

### Custom Features
- **Auto-fix**: Quickfix command (`qf`) to automatically apply LSP fixes
- **Script Runner**: Execute `./run.sh` in a split terminal with `<leader>rs`
- **Git Conflict Resolution**: Bulk accept/reject incoming changes
- **Todo Management**: Personal todo file in popup window
- **Note Management**: Create and search numbered markdown notes
- **File Explorer**: Oil.nvim for intuitive file navigation

## Installation

### Prerequisites
- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- ripgrep (for Telescope grep)
- Node.js (for some LSP servers)

### Setup

1. **Backup your existing config** (if you have one):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Clone this repository**:
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. **Start Neovim**:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

4. **Install LSP servers**:
```vim
:Mason
```
Then install the language servers you need.

## Project Structure

```
.
├── init.lua                      # Entry point
├── lazy-lock.json                # Plugin version lock file
├── lua/
│   └── allef/
│       ├── lazy.lua              # Lazy.nvim configuration
│       ├── core/                 # Core configuration
│       │   ├── keymaps.lua       # Core keybindings
│       │   ├── options.lua       # Neovim options
│       │   ├── fix_issue.lua     # Auto-fix utility
│       │   ├── run_script.lua    # Script runner
│       │   ├── accept_reject_incoming_changes.lua  # Git conflict resolution
│       │   ├── todo.lua          # Todo management
│       │   ├── note.lua          # Note management
│       │   └── write_mode.lua    # Writing mode setup
│       └── plugins/              # Plugin configurations
│           ├── lsp.lua           # LSP configuration
│           ├── telescope.lua     # Telescope setup
│           ├── nvim-cmp.lua      # Completion setup
│           ├── treesitter.lua    # Treesitter config
│           ├── nvim-dap.lua      # Debugging setup
│           ├── harpoon.lua       # File navigation
│           ├── oil.lua           # File explorer
│           ├── gitsigns.lua      # Git integration
│           └── ...               # Other plugins
├── ftplugin/                     # Filetype-specific settings
├── KEYMAPS.md                    # Complete keymap reference
└── README.md                     # This file
```

## Keymaps

For a complete list of all custom keymaps, see **[KEYMAPS.md](KEYMAPS.md)**.

### Quick Reference

**Leader Key**: `<Space>`

#### Essential Keymaps
| Keymap | Description |
|--------|-------------|
| `jk` | Exit insert/terminal mode |
| `<C-p>` | Find files |
| `<leader>fg` | Live grep |
| `<leader>ff` | File browser |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `ac` | Code actions |
| `qf` | Auto-fix issue on current line |
| `-` or `<C-n>` | Open file explorer |
| `<leader>rs` | Run ./run.sh script |

For the complete keymap list, see [KEYMAPS.md](KEYMAPS.md).

## Configuration

### Adding a New Plugin

Create a new file in `lua/allef/plugins/` following the lazy.nvim spec format:

```lua
return {
    "author/plugin-name",
    dependencies = {
        "other/plugin",
    },
    config = function()
        -- Plugin configuration
    end,
}
```

### Adding LSP Servers

1. Install the server via Mason (`:Mason`)
2. Add configuration in `lua/allef/plugins/nvim-cmp.lua`:

```lua
nvim_lsp.your_server.setup({
    capabilities = capabilities,
})
```

### Filetype-Specific Settings

Create a file in `ftplugin/` directory:
```
ftplugin/python.lua
ftplugin/javascript.lua
```

## Custom Commands

### Note Management
- `:NCreateFile [name]` - Create a numbered note file
- `:NSearch [pattern]` - Search across markdown files

### Git
- `:AcceptAllIncoming` - Accept all incoming changes in conflicts
- `:RejectAllIncoming` - Reject all incoming changes in conflicts

### Todo
- `:Todo` - Open todo file in popup

## Workflow Tips

### Project Navigation
1. Use `<C-p>` to quickly find files
2. Mark frequently used files with Harpoon (`<leader>af`)
3. Navigate between marked files with `<Tab>` and `<S-Tab>`

### Code Development
1. Use LSP features: `gd`, `gr`, `K`, `<leader>rn`
2. Fix issues quickly with `qf`
3. Use `ac` for code actions and refactoring
4. Find and replace with `<leader>rt`

### Debugging
1. Set breakpoints with `<leader>bp`
2. Start debugging with `<leader>dd`
3. Navigate with `<leader>dn`, `<leader>dsi`, `<leader>dso`
4. Toggle debug UI with `<leader>di`

### Git Workflow
1. View inline git changes with Gitsigns (automatic)
2. Resolve conflicts with `<leader>aai` or `<leader>rai`

## Troubleshooting

### LSP not working
1. Check if the LSP server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `:LspRestart`

### Plugins not loading
1. Check plugin status: `:Lazy`
2. Update plugins: `:Lazy update`
3. Sync plugins: `:Lazy sync`

### Telescope search not working
- Ensure `ripgrep` is installed: `brew install ripgrep` (macOS) or equivalent

## Contributing

This is a personal configuration, but feel free to fork and adapt it to your needs!

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
