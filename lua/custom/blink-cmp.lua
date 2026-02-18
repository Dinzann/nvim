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

        -- 注意：blink 的 accept 不需要用 function 包裹，直接字符串性能更好
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
        -- 如果你用的是 Nerd Font Mono，这里用 'mono'
        nerd_font_variant = 'mono'
    },

    -- 补全菜单配置
    completion = {
        -- 只有在你手动触发时才显示文档（设为 true 则自动显示）
        documentation = { auto_show = false },
        -- 建议给菜单加个边框，看起来更高级
        menu = { border = 'rounded' },
        -- ghost_text = { enabled = false },
    },

    snippets = {
        preset = 'luasnip', -- 关键：让 blink 使用 LuaSnip 而不是内置引擎
    },

    -- 补全来源：LSP, 路径, 代码片段, 缓冲区
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- 模糊匹配设置
    -- "prefer_rust_with_warning" 会优先寻找预编译的 Rust 模块
    fuzzy = { implementation = "prefer_rust_with_warning" }
})
require("luasnip.loaders.from_vscode").lazy_load()
