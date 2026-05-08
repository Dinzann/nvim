vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("SetupCompletion", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/saghen/blink.cmp" },
            { src = "https://github.com/L3MON4D3/LuaSnip" },
            { src = "https://github.com/rafamadriz/friendly-snippets" },
            { src = "https://github.com/echasnovski/mini.icons" },
        })

        require("mini.icons").setup()
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
                list = {
                    selection = { preselect = false, auto_insert = true }
                },
                menu = {
                    scrollbar = true,
                    border = "bold",
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "kind_icon",  gap = 1 },
                            { "label",      "label_description", gap = 1 },
                            { "source_name" }
                        },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return icon
                                end,
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                            source_name = {
                                text = function(ctx)
                                    local labels = {
                                        lsp = "LSP",
                                        snippets = "Snip",
                                        buffer = "Buf",
                                        path = "Path",
                                        codeium = "AI"
                                    }
                                    local name = labels[ctx.source_id] or ctx.source_name
                                    return "[" .. name .. "]"
                                end,
                                highlight = "NonText",
                            },
                        },
                    },
                },
                trigger = {
                    show_on_backspace = true,
                    prefetch_on_insert = false
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    window = { border = "rounded" },
                },
            },
            sources = {
                default = { "codeium", "lsp", "path", "snippets", "buffer" },
                providers = {
                    codeium = {
                        name = "Codeium",
                        module = "codeium.blink",
                        async = true,
                        score_offset = 100,
                        enabled = function()
                            local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
                            return buftype ~= "prompt" and buftype ~= "nofile"
                        end,
                    },
                },
            },
            cmdline = {
                completion = {
                    menu = { auto_show = true },
                },
            },
            snippets = { preset = "luasnip" },
            signature = { enabled = true, window = { border = "rounded" } },
        })
    end,
})
