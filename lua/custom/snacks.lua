local Snacks = Snacks

require("snacks").setup({
    image = {
        enabled = true,
        math = {
            enabled = true,
            inline = false,
            float = true,
        },
    },

    indent = {
        enabled = true,
        priority = 1,
        char = "│",
        only_scope = false,
        only_current = false,

        animate = {
            enabled = false,
            style = "out",
        },

        scope = {
            enabled = true,
            char = "┃",
            underline = false,
        },
    },
    dim = {
        enabled = true,
        scope = {
            enabled = true,
            from = 2,
            to = 10,
        },
        opacity = 0.1,
        filter = function()
            return vim.g.snacks_dim ~= false -- 提供一个全局开关
        end,

        -- 切换代码聚焦（昏暗掉非工作区）
        vim.keymap.set("n", "<leader>sd", function()
            if Snacks.dim.enabled then
                Snacks.dim.disable()
            else
                Snacks.dim.enable()
            end
        end, { desc = "Snacks: Toggle Zoom Mode" })
    },
})
