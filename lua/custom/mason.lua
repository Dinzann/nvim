require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls", -- Lua
        "pylsp",  --python
        "taplo",   --toml
        "clangd", --cpp
        "ts_ls", --javascript & typescript
        "cssls"  --css
    },
})

