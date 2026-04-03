vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" }
})

require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    folds = { enable = true },
}

require('nvim-treesitter').install {
    'rust',
    'javascript',
    'zig',
    'lua',
    'python',
    'kitty',
    'markdown', 'markdown_inline',
    'latex',
    'typst',
    'css',
    'html',
    'regex',
    'nix'
}
