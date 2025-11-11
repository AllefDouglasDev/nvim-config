# Neovim Custom Keymaps

This document lists all custom keymaps configured in this Neovim setup. The leader key is set to `<Space>`.

## Table of Contents
- [Core Keymaps](#core-keymaps)
- [LSP Keymaps](#lsp-keymaps)
- [Telescope Keymaps](#telescope-keymaps)
- [File Navigation](#file-navigation)
- [Harpoon Keymaps](#harpoon-keymaps)
- [Git Operations](#git-operations)
- [Debugging (DAP)](#debugging-dap)
- [Completion (nvim-cmp)](#completion-nvim-cmp)
- [Todo Management](#todo-management)
- [Custom Utilities](#custom-utilities)

---

## Core Keymaps

Basic editor operations and window management.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `i`, `t` | `jk` | `<ESC>` | Exit to normal mode |
| `n` | `<leader>h` | `:vertical resize +5<CR>` | Increase window width |
| `n` | `<leader>l` | `:vertical resize -5<CR>` | Decrease window width |
| `n` | `<leader>j` | `:resize -5<CR>` | Decrease window height |
| `n` | `<leader>k` | `:resize +5<CR>` | Increase window height |
| `n` | `<C-x>` | `:noh<CR>` | Clear search highlighting |
| `n` | `<C-d>` | `<C-d>zz` | Scroll down and center cursor |
| `n` | `<C-u>` | `<C-u>zz` | Scroll up and center cursor |
| `n` | `<leader>qn` | `:cnext<CR>` | Next quickfix item |
| `n` | `<leader>qp` | `:cprev<CR>` | Previous quickfix item |
| `n` | `<leader>ww` | `:set wrap<CR>` | Enable word wrap |
| `n` | `<leader>wo` | `:set nowrap<CR>` | Disable word wrap |
| `n` | `<leader>mp` | `:!md %<CR>` | Markdown preview |

---

## LSP Keymaps

Language Server Protocol operations for code intelligence.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `gd` | Telescope LSP definitions | Go to definition |
| `n` | `gi` | `vim.lsp.buf.implementation` | Go to implementation |
| `n` | `gr` | Telescope LSP references | Go to references |
| `n` | `K` | `vim.lsp.buf.hover` | Show hover documentation |
| `n` | `<leader>rn` | `vim.lsp.buf.rename` | Rename symbol |
| `n` | `<leader>x` | `vim.diagnostic.open_float` | Open diagnostic float window |
| `n` | `<leader>sh` | `vim.lsp.buf.signature_help` | Show signature help |
| `n` | `<leader>df` | `vim.diagnostic.goto_next` | Go to next diagnostic |
| `n` | `<leader>q` | `vim.diagnostic.setloclist` | Set diagnostics to location list |
| `n` | `ac` | `vim.lsp.buf.code_action` | Show code actions |
| `n` | `<leader>sd` | Telescope diagnostics | Show all diagnostics |
| `n` | `<leader>rt` | Find and replace pattern | Find and replace word under cursor |
| `n`, `v` | `qf` | `:lua fix()<CR>` | Auto-fix current line issues (quickfix) |

---

## Telescope Keymaps

Fuzzy finder for files, buffers, and more.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<C-p>` | Telescope find_files | Find files (respects .gitignore) |
| `n` | `<leader>p` | Telescope find_files | Find all files (including hidden) |
| `n` | `<leader>fg` | Telescope live_grep | Live grep search in files |
| `n` | `<leader>fb` | Telescope buffers | List open buffers |
| `n` | `<leader>fh` | Telescope help_tags | Search help documentation |
| `n` | `<leader>fq` | Telescope quickfix | Show quickfix list |
| `n` | `<leader>ff` | Telescope file_browser | Open file browser |

---

## File Navigation

File explorer and navigation tools.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `-` | `:Oil<cr>` | Open Oil file explorer |
| `n` | `<C-n>` | `:Oil<cr>` | Open Oil file explorer |
| `n` | `<leader>-` | Oil toggle_float | Open Oil in floating window |

---

## Harpoon Keymaps

Quick navigation between marked files.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<leader>af` | Harpoon add file | Add current file to harpoon |
| `n` | `<leader>fh` | Harpoon quick menu | Toggle harpoon quick menu |
| `n` | `<Tab>` | Harpoon nav next | Navigate to next harpoon file |
| `n` | `<S-Tab>` | Harpoon nav prev | Navigate to previous harpoon file |

---

## Git Operations

Git conflict resolution and operations.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<leader>aai` | `:AcceptAllIncoming<CR>` | Accept all incoming changes (theirs) |
| `n` | `<leader>rai` | `:RejectAllIncoming<CR>` | Reject all incoming changes (ours) |

---

## Debugging (DAP)

Debug Adapter Protocol keymaps for debugging.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<leader>dd` | DAP continue | Start/continue debugging |
| `n` | `<leader>de` | DAP terminate | Terminate debugging session |
| `n` | `<leader>dn` | DAP step over | Step over (next line) |
| `n` | `<leader>dsi` | DAP step into | Step into function |
| `n` | `<leader>dso` | DAP step out | Step out of function |
| `n` | `<leader>bp` | DAP toggle breakpoint | Toggle breakpoint |
| `n` | `<leader>di` | DAP UI toggle | Toggle DAP UI |

---

## Completion (nvim-cmp)

Autocompletion keymaps in insert mode.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `i` | `<C-b>` | Scroll docs backward | Scroll completion documentation up |
| `i` | `<C-f>` | Scroll docs forward | Scroll completion documentation down |
| `i` | `<C-Space>` | Complete | Trigger completion menu |
| `i` | `<C-e>` | Abort | Close completion menu |
| `i` | `<CR>` | Confirm | Accept selected completion item |

---

## Todo Management

Personal todo file management.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<leader>tt` | `:Todo<CR>` | Open todo file in popup window |

---

## Custom Utilities

Custom scripts and utilities for workflow enhancement.

| Mode | Keymap | Action | Description |
|------|--------|--------|-------------|
| `n` | `<leader>rs` | `:lua run_script()<CR>` | Run ./run.sh in split terminal |

---

## Custom Commands

### Note Management Commands
- `:NCreateFile [name]` - Create a new numbered note file in the current directory
- `:NSearch [pattern]` - Search for pattern across all markdown files

### Git Conflict Commands
- `:AcceptAllIncoming` - Accept all incoming changes in git conflicts
- `:RejectAllIncoming` - Reject all incoming changes in git conflicts

### Todo Commands
- `:Todo` - Open todo file in popup window

---

## Notes

- **Leader Key**: `<Space>` (spacebar)
- **Telescope Integration**: Many LSP functions use Telescope for better UI
- **Git Conflicts**: Requires `git-conflict.nvim` plugin for conflict resolution commands
- **File Explorer**: Uses Oil.nvim as the primary file explorer instead of netrw
- **Completion**: nvim-cmp is configured with LSP, buffer, path, and snippet sources
