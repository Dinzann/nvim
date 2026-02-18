require('blink.cmp').setup({
    -- 键位设置：'default' 模式下，Ctrl+y 确认，Ctrl+n/p 选择
    keymap = {
        preset = 'none',
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        -- 关闭补全并回车：hide 之后返回 false 触发 fallback (即回车换行)
        ["<S-CR>"] = { function(cmp)
            cmp.hide()
            return false
        end, "fallback" },

        -- 切换显示/隐藏
        ["<A-/>"] = {
            function(cmp)
                if cmp.is_visible() then return cmp.hide() else return cmp.show() end
            end,
            "fallback"
        },

        -- 强制只显示 buffer 来源的补全
        ["<A-n>"] = { function(cmp) cmp.show({ providers = { "buffer" } }) end },
        ["<A-p>"] = { function(cmp) cmp.show({ providers = { "buffer" } }) end },
    },

    appearance = {
        nerd_font_variant = 'mono'
    },

    -- 补全菜单配置
    completion = {
        documentation = { auto_show = false },
        menu = { border = 'rounded' },
        -- ghost_text = { enabled = false },
    },

    snippets = {
        preset = 'luasnip',
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
})
require("luasnip.loaders.from_vscode").lazy_load()
