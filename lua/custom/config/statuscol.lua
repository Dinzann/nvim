vim.pack.add({
    { src = "https://github.com/luukvbaal/statuscol.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" }
})

local builtin = require("statuscol.builtin")
require("statuscol").setup({
    relculright = true,
    segments = {
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- 仅显示图标
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- 行号
        { text = { "%s" }, click = "v:lua.ScSa" },
    }
})
