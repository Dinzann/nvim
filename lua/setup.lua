-- Yazi.nvim
require("yazi").setup({
    open_for_directories = false,
    keymaps = {
        show_help = "<f1>",
    },
})

-- Blink.cmp
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

-- Mason.nvim & Mason-lspconfig
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls", -- Lua
        "pylsp"   --python
    },
})

-- nvim-treesitter.nvim
require('nvim-treesitter.config').setup({
    -- 确保安装这些基础解析器
    ensure_installed = { "lua", "vim", "vimdoc", "python", "markdown", "markdown_inline" },

    -- 启用高亮
    highlight = {
        enable = true,
        -- 禁用内置的正则高亮，完全交给 treesitter
        additional_vim_regex_highlighting = false,
    },

    -- 启用智能缩进
    indent = { enable = true },
})

-- outline.nvim
require("outline").setup({
    -- 这里可以放你的自定义配置，比如：
    outline_window = {
        position = 'right',
        width = 25,
        auto_close = false,
    },
    symbol_folding = {
        autofold_depth = 1, -- 默认折叠深度
    },
})

-- bufferline.nvim
require("bufferline").setup({
    options = {
        -- 诊断信息显示逻辑（错误、警告、提示图标）
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " " or (e == "warning" and " " or " ")
                s = s .. n .. sym
            end
            return s
        end,
        -- 只有一个 Buffer 时隐藏 BufferLine，保持界面简洁
        always_show_bufferline = false,
        -- 如果你用了某些主题，可能需要 offsets 配置来避开侧边栏（如 outline）
        offsets = { {
            filetype = "outline",
            text = "Symbol Outline",
            text_align = "left",
            separator = true,
        },
        },
    },
})

-- lspsaga.nvim
require('lspsaga').setup({
    -- Top beautiful
    symbol_in_winbar = {
        enable = true,
        separator = ' › ',
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        color_mode = true,
    },
    -- UI beautiful
    ui = {
        border = 'rounded', -- Rounded ui
        devicon = true,
        code_action = '💡', -- Code visual icon
    },
    lightbulb = { enable = false }, -- Close bad lifht
    hover = {
        max_width = 0.6,
        open_link = 'gx',
    },
    rename = {
        quit = '<C-c>',
        mark = 'x',
        confirm = '<CR>',
    },
})

-- lualine.nvim
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- notice.nvim
require("noice").setup({
    cmdline = { view = "cmdline" },
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
})

-- comment.nvim
require("Comment").setup({
    padding = true,
    sticky = true,
    ignore = "^$",
    -- 这里保持插件默认的触发逻辑，不影响我们外部定义快捷键
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
})

-- oil.nvim
require("oil").setup()

--which-key.nvim
require('which-key').setup {
    ---@param ctx { mode: string, operator: string }
    defer = function(ctx)
        if vim.list_contains({ 'd', 'y' }, ctx.operator) then
            return true
        end
        return vim.list_contains({ 'v', '<C-V>', 'V' }, ctx.mode)
    end,
    preset = 'modern',
    show_help = false,
    icons = {
        colors = true,
        keys = {
            -- Up = '􀄨',
            -- Down = '􀄩',
            -- Left = '􀄪',
            -- Right = '􀄫',
            -- C = '􀆍',
            -- M = '􀆕',
            -- S = '􀆝',
            -- CR = '􀅇',
            -- Esc = '􀆧',
            ScrollWheelDown = '󱕐',
            ScrollWheelUp = '󱕑',
            -- NL = '􀅇',
            -- BS = '􁂉',
            -- Space = '󱁐',
            -- Tab = '􀅂',
        },
    },
}

require('which-key').add {
    { 'g', group = 'Go to', icon = '󰿅' },
    -- { '<leader>a', group = 'Avante', icon = '󰚩' },
    { '<leader>b', group = 'Buffer', icon = '' },
    -- { '<leader>d', group = 'DAP', icon = '' },
    -- { '<leader>c', group = 'DiffView', icon = '' },
    { '<leader>g', group = 'Git', icon = '' },
    { '<leader>l', group = 'Lsp', mode = 'n', icon = '' },
    { '<leader>r', group = 'Overseer tasks', mode = 'n', icon = '󰑮' },
    { '<leader>f', group = 'Find', mode = 'n' },
    { '<leader>t', group = 'Toggle' },
    -- { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
    -- { '<leader>P', group = 'Picture', icon = '' },
    -- { '<leader>x', group = 'Execute Lua', icon = '', mode = { 'n', 'v' } },
}
