vim.pack.add({
    { src = "https://github.com/Exafunction/windsurf.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("codeium").setup({
    enable_cmp_source = false,
})
