---@diagnostic disable: missing-return

local lz = require("lz.n")

lz.load({
    {
        "Comment.nvim",
        before = function()
            vim.pack.add({
                { src = "https://github.com/numToStr/Comment.nvim" },
            })
        end,
        keys = {
            { "<leader>/", "gcc", mode = "n", remap = true, desc = "Toggle comment line" },
            { "<leader>/", "gc",  mode = "v", remap = true, desc = "Toggle comment visual" },
        },
        after = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = "^$",
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },
                pre_hook = function() end,
                post_hook = function() end,
            })
            vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
            vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment visual" })
        end,
    },
})
