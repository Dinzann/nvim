require('lspsaga').setup({
    -- Top beautiful
    symbol_in_winbar = {
        enable = true,
        separator = ' › ',
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        color_mode = true,
    },
    -- UI beautiful
    ui = {
        border = 'rounded', -- Rounded ui
        devicon = true,
        code_action = '💡', -- Code visual icon
    },
    lightbulb = { enable = false }, -- Close bad lifht
    hover = {
        max_width = 0.6,
        open_link = 'gx',
    },
    rename = {
        quit = '<C-c>',
        mark = 'x',
        confirm = '<CR>',
    },
})

