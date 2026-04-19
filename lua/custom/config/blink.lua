vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    completion = {
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
            border = 'rounded',
            auto_show = true,
            draw = {
                treesitter = { "lsp" },
            },
        },
        trigger = {
            show_on_backspace = true,
            prefetch_on_insert = false
        },
    },
    sources = {
        default = { "codeium", "lsp", "path", "snippets", "buffer" },
        providers = {
            codeium = {
                name = "Codeium",
                module = "codeium.blink",
                async = true,
                score_offset = 100
            },
        },
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true },
})
