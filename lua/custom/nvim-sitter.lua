require('nvim-treesitter.config').setup({
    ensure_installed = { "lua", "vim", "vimdoc", "python", "markdown", "markdown_inline" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },
})
