vim.pack.add({
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
    library = {
        { path = "luv", types = true },
        { path = "vim", types = true },
        { path = "lua", types = true },
    },
})

require("lsp.keymapping")

local signs = {
    [vim.diagnostic.severity.ERROR] = '󰅚 ',
    [vim.diagnostic.severity.WARN]  = '󰀪 ',
    [vim.diagnostic.severity.HINT]  = '󰌶 ',
    [vim.diagnostic.severity.INFO]  = '󰋽 ',
}

vim.diagnostic.config({
    signs = { text = signs },
    virtual_text = {
        spacing = 4,
        prefix = '',
        severity_sort = true,
    },
    float = {
        border = "rounded",
        style = "minimal",
        -- source = "always",
        header = "",
    },
    severity_sort = true,
})

local function set_diagnostic_hl()
    local colors = { error = "#ed8796", warn = "#eed49f", info = "#8bd5ca", hint = "#91d7e3" }
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.error })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.warn })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.info })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.hint })
end
set_diagnostic_hl()

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
