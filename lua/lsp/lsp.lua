vim.pack.add({
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
})

require("lsp.keymapping")

vim.diagnostic.config {
    virtual_text = {
        spacing = 4,
        prefix = ''
    },
    float = { severity_sort = true },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.WARN] = ''
        }
    }
}

require("lazydev").setup({
    library = {
        { path = "luv", types = true },
        { path = "vim", types = true },
        { path = "lua", types = true },
    },
})

require("mason").setup({
    ui = {
        border = "rounded",
    },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('ts_ls')
vim.lsp.enable('bashls')

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "ts_ls",
        "bashls"
    }
})
