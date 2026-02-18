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
        offsets = { {
            filetype = "outline",
            text = "Symbol Outline",
            text_align = "left",
            separator = true,
        },
        },
    },
})
