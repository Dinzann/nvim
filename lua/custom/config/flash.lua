vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" }
})

require('flash').setup()

-- 1. 基础跳转 (Normal, Visual, Operator-pending)
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })

-- 2. Treesitter 选择 (Normal, Visual, Operator-pending)
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- 3. 修正这里：Remote 模式映射在 Lua API 中通常归类为 "o"
-- 或者直接使用 "o" 来捕获算子待决状态
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })

-- 4. 针对 Treesitter Search，使用 "o" 和 "x" 模式
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })

-- 5. 命令行映射 (Command-line)
vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
