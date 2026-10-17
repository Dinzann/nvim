vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" },
})
require("tokyonight").setup({
    -- use the night style
    style = "night",
    -- disable italic for functions
    styles = {
        functions = {}
    },
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
    end
})
