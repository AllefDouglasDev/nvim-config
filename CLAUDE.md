# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration written in Lua, organized with a modular structure:

- **Entry Point**: `init.lua` loads the core configuration and lazy.nvim plugin manager
- **Core Configuration**: `lua/allef/core/` contains fundamental Neovim settings, keymaps, and custom utilities
- **Plugin Management**: `lua/allef/lazy.lua` configures lazy.nvim plugin manager
- **Plugin Configurations**: `lua/allef/plugins/` contains individual plugin setup files
- **Filetype Settings**: `ftplugin/` contains language-specific configurations

## Key Custom Features

### Core Utilities (lua/allef/core/)
- **fix_issue.lua**: Auto-fixes LSP diagnostics with `qf` keymap for quickfix actions
- **run_script.lua**: Executes `./run.sh` in a split terminal with `<leader>rs`
- **accept_reject_incoming_changes.lua**: Git conflict resolution with `<leader>aai` (accept all) and `<leader>rai` (reject all)
- **write_mode.lua**: Custom writing mode functionality
- **save_folder_file.lua**: File saving utilities
- **file_autocomplete.lua**: Enhanced file completion

### Plugin Architecture
All plugins are configured as lazy.nvim specs in separate files under `lua/allef/plugins/`. Key plugins include:
- **LSP**: Mason + nvim-lspconfig with Telescope integration
- **Completion**: nvim-cmp with multiple sources
- **Git**: Gitsigns and lazygit integration
- **Navigation**: Telescope, nvim-tree, oil.nvim, harpoon
- **AI**: Avante.nvim and Codeium for AI assistance
- **Debugging**: nvim-dap for debug adapter protocol

## Key Keybindings

### Leader Key: `<space>`

### Navigation & Window Management
- `jk` (insert/terminal): Exit to normal mode
- `<leader>h/j/k/l`: Resize windows
- `<C-x>`: Clear search highlighting
- `<C-d>/<C-u>`: Scroll with cursor centering

### LSP & Development
- `gd`: Go to definition (Telescope)
- `gr`: Go to references (Telescope)
- `gi`: Go to implementation
- `K`: Hover documentation
- `<leader>rn`: Rename symbol
- `<leader>x`: Open diagnostic float
- `ac`: Code actions
- `qf`: Auto-fix current line issues
- `<leader>rt`: Find and replace word under cursor

### Custom Workflows
- `<leader>rs`: Run `./run.sh` script in split terminal
- `<leader>aai`: Accept all incoming changes in git conflicts
- `<leader>rai`: Reject all incoming changes in git conflicts
- `<leader>sd`: Show all diagnostics (Telescope)

## Development Workflow

### Plugin Management
- Plugins are automatically installed via lazy.nvim
- Lock file: `lazy-lock.json` tracks exact plugin versions
- Plugin configurations are modular in `lua/allef/plugins/`

### LSP Configuration
- Uses Mason for LSP server management (manual installation)
- LSP servers need to be installed separately through Mason
- Telescope integration for LSP navigation
- Diagnostic signs and floating windows configured

### Git Integration
- Custom git conflict resolution commands
- Gitsigns for inline git information
- Lazygit integration for full git UI

### Language Support
- Filetype-specific configurations in `ftplugin/`
- Treesitter for syntax highlighting
- Language servers via LSP
- Debug configurations via nvim-dap

## File Structure Conventions

When modifying this configuration:
- Add new plugins to `lua/allef/plugins/` as separate files
- Core functionality goes in `lua/allef/core/`
- Language-specific settings go in `ftplugin/{language}.lua`
- Follow the existing lazy.nvim plugin spec format
- Maintain modular structure - one plugin per file
