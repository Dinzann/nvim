vim.pack.add({
    { src = "https://github.com/zbirenbaum/copilot.lua" }
})

require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
        markdown = true,
        help = true
    }
})
