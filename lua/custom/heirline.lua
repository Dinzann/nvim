local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- 1. 颜色面板：提取自你提供的截图色调
local colors = {
    bg = "#1a1b26",        -- 底部状态栏背景 black = "#15161e",       -- 胶囊文字颜色（通常用深色）
    bright_bg = "#3b4261", -- 辅助背景
    text = "#a9b1d6",      -- 普通文本颜色

    -- 模式颜色
    normal = "#7aa2f7",  -- 蓝色
    insert = "#73daca",  -- 青色/绿色
    visual = "#e0af68",  -- 黄色/橙色
    replace = "#f7768e", -- 红色
    command = "#9ece6a", -- 浅绿

    -- 诊断颜色
    diag_error = "#db4b4b",
    diag_warn = "#e0af68",
    diag_info = "#0db9d7",
    diag_hint = "#1abc9c",
}

-- 2. 封装函数：创建圆角胶囊样式
-- @param component 核心组件内容
-- @param color_func 返回背景颜色的函数
local function pill_wrapper(component, color_func)
    return {
        {
            provider = "",
            hl = function(self) return { fg = color_func(self), bg = "bg" } end,
        },
        {
            component,
            hl = function(self) return { bg = color_func(self), fg = "black", bold = true } end,
        },
        {
            provider = "",
            hl = function(self) return { fg = color_func(self), bg = "bg" } end,
        },
    }
end

--- 3. 各大组件定义 ---

-- A. 模式组件 (NORMAL/INSERT/VISUAL...)
local ViMode = pill_wrapper({
    provider = function()
        local m = vim.fn.mode(1):sub(1, 1)
        local names = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            R = "REPLACE",
            t = "TERM"
        }
        -- 加上你截图中的 ◉ 图标
        return " ◉ " .. (names[m] or "NORMAL") .. " "
    end,
}, function()
    local m = vim.fn.mode(1):sub(1, 1)
    local mode_colors = {
        n = "normal",
        i = "insert",
        v = "visual",
        V = "visual",
        ["\22"] = "visual",
        c = "command",
        R = "replace",
        t = "insert"
    }
    return mode_colors[m] or "normal"
end)

-- B. 文件路径 (带图标，路径显示为 ~/...)
local FileName = {
    provider = function()
        local icon = "󰈚 "
        local path = vim.fn.expand("%:~:.")
        if path == "" then return icon .. "[No Name]" end
        return icon .. path
    end,
    hl = { fg = "text", italic = true },
}

-- C. LSP 诊断 (只有报错或警告时才出现的红色/黄色胶囊)
local Diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    end,
    update = { "DiagnosticChanged", "BufEnter" },

    -- 使用包裹函数实现胶囊化
    unpack(pill_wrapper({
        provider = function(self)
            local res = ""
            if self.errors > 0 then res = res .. " " .. self.errors .. " " end
            if self.warnings > 0 then res = res .. " " .. self.warnings end
            return (res ~= "" and " " .. res .. " ") or nil
        end,
    }, function(self)
        -- 如果有错误显红色，只有警告显黄色
        return self.errors > 0 and "diag_error" or "diag_warn"
    end))
}

-- D. LSP 服务名称 (显示当前文件挂载的 LSP)
local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    provider = function()
        local names = {}
        -- 核心改动：将 get_active_clients({ bufnr = 0 }) 替换为 get_clients({ bufnr = 0 })
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return "  [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "diag_info", bold = true },
}

-- E. 占位符
local Spacer = { provider = "%=" }

-- F. 位置/行号组件 (显示为：  15/100 : 5)
local Ruler = pill_wrapper({
    provider = function()
        -- %l 是当前行，%L 是总行数，%c 是列数
        --  是 Powerline 风格的行号图标
        return "LN %l/%L : %c "
    end,
}, function()
    -- 给行号胶囊一个固定的颜色，比如紫色，区分于模式和诊断
    return "normal" -- 记得在你的 colors 表里定义 purple = "#cba6f7"
end)

--- 4. 最终组装 ---

local StatusLine = {
    hl = { bg = "bg" },
    { provider = "  " }, -- 最左侧留白
    ViMode,              -- 模式胶囊
    { provider = "  " },
    FileName,            -- 文件路径
    Spacer,              -- 撑开中间
    LSPActive,           -- LSP 状态
    { provider = " " },
    Ruler,               -- 行号胶囊
    { provider = " " },
    Diagnostics,         -- 诊断胶囊
    { provider = "  " }, -- 最右侧留白
}

-- 5. 初始化配置
require("heirline").setup({
    statusline = StatusLine,
    opts = {
        colors = colors,
    }
})
