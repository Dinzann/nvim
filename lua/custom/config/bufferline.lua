vim.pack.add({
    { src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
    options = {
        mode = "buffers",                            -- 使用 buffers 模式
        style_preset = require("bufferline").style_preset.default,
        separator_style = "slope",                   -- 分割符风格: "slant" | "slope" | "thick" | "thin"
        right_mouse_command = "vertical sbuffer %d", -- 右键点击在新窗口打开
        left_mouse_command = "buffer %d",            -- 左键点击切换
        middle_mouse_command = "bdelete! %d",        -- 中键点击关闭

        -- 重点：侧边栏偏移（让 bufferline 不会盖在文件树上方）
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                text_align = "center",
                separator = true,
            }
        },

        -- 诊断图标配置（需要 LSP 支持）
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or (level:match("warning") and " " or "󰌵")
            return " " .. icon .. count
        end,

        -- 美化显示
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        enforce_regular_tabs = false,
        always_show_bufferline = false,

        -- 选中状态下的指示器（左侧的小竖条）
        indicator = {
            style = 'icon',
            icon = '▎',
        },
    }
})

vim.keymap.set('n', 'tt', '<cmd>BufferLinePick<CR>', { desc = "BufferLine: Pick" })
vim.keymap.set('n', 'th', '<cmd>BufferLineCyclePrev<CR>', { desc = "BufferLine: Left Tab" })
vim.keymap.set('n', 'tl', '<cmd>BufferLineCycleNext<CR>', { desc = "BufferLine: Right Tab" })
vim.keymap.set('n', 'tq', '<cmd>BufferLinePickClose<CR>', { desc = "BufferLine: Close Tab" })
-- vim.keymap.set("n", "td", "<cmd>bdelete<CR>", { desc = "BufferLine: Delete Tab" })
