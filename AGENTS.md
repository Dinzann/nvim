# Neovim Config (Dinzann)

## Plugin manager

Uses **`vim.pack.add()`** (Neovim 0.12+ native). Each plugin config under `lua/custom/config/*.lua` declares its own `vim.pack.add({...})` call at the top. Lockfile: `nvim-pack-lock.json`.

## LSP

Neovim 0.12+ native LSP. Server configs in `lsp/*.lua` return `vim.lsp.Config` tables. Main setup at `lua/lsp/lsp.lua` calls `vim.lsp.enable('server_name')`. Enabled servers: `lua_ls`, `pyright`, `clangd`, `ts_ls`, `bashls`, `tinymist`.

## Load order (from `init.lua`)

```
custom.autocmds -> custom.options -> custom.keymapping -> custom.folding
  -> plugins (requires ~20 custom.config.* modules via lua/plugins.lua)
  -> lsp.lsp (mason, lazydev, diagnostics, vim.lsp.enable)
```

## Key non-obvious details

- **Completion:** `blink.cmp` (not nvim-cmp). Snippets via `LuaSnip` + `friendly-snippets`.
- **File explorer:** `mini.files` enabled. `oil.nvim` and `yazi.nvim` configured but **commented out**.
- **AI:** `opencode.nvim` launches in a separate tmux window (`<leader>oa`). Windsurf/codeium configured but **disabled in blink sources**.
- **Plugin manager UI:** `vpack.nvim`.
- **Dashboard:** `snacks.nvim` with custom ASCII art from `lua/utils/logo.lua`.
- **Statusline:** `heirline.nvim` with custom components in `lua/custom/config/heirline/`.
- **Navigation:** `flash.nvim` bound to `s`/`S`.

## Formatting

`conform.nvim` at `lua/custom/config/conform.lua`. Format on save enabled (500ms timeout, LSP fallback). `<leader>lf` manually triggers formatting. Formatters by filetype: `stylua` (lua), `ruff_format` (python), `rustfmt` (rust), `clang-format` (c/cpp), `prettierd`/`prettier` (js/ts/react/json/html/css/md/yaml), `shfmt` (sh/bash).

## No build/test/lint tooling

This is a runtime Neovim config, not a development project.
