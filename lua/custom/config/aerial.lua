vim.keymap.set("n", "<leader>to", function()
    if not package.loaded["aerial"] then
        vim.pack.add({
            { src = "https://github.com/stevearc/aerial.nvim" },
        })
        require("aerial").setup({
            backends = { "lsp", "treesitter", "markdown" },
            layout = {
                max_width = { 50, 0.2 },
                min_width = 30,
                win_opts = {
                    winhighlight = "Normal:Normal",
                    relativenumber = false,
                    number = false,
                },
            },
            attach_mode = "window",
            show_guides = true,
            filter_kind = false,
            guides = {
                child_folder = true,
                child_folder_indent = true,
                last_child = true,
                multiline = true,
            },
            icons = {
                Class = "󰌗 ",
                Constant = "󰏿 ",
                Constructor = " ",
                Enum = "󰕘",
                EnumMember = "󰕘",
                Event = "󰕘",
                Field = "󰆘 ",
                File = "󰈔 ",
                Function = "󰊔 ",
                Interface = "󰕘",
                Method = "󰆘 ",
                Module = "󰕘",
                Namespace = "󰕘",
                Number = "󰕘",
                Operator = "󰕘",
                Package = "󰕘",
                Property = "󰆘 ",
                Struct = "󰌗 ",
                TypeParameter = "󰕘",
                Variable = "󰆘 ",
            },
            manage_folds = false,
            close_on_select = false,
            highlight_on_hover = false,
            open_automatic = false,
        })
    end

    require("aerial").toggle()
end, { desc = "Toggle aerial outline (Lazy)" })

local function aerial_nav(direction)
    if package.loaded["aerial"] then
        if direction == "next" then require("aerial").next() else require("aerial").prev() end
    else
        vim.notify("Aerial 尚未开启，请先按 <leader>to", vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "<leader>tj", function() aerial_nav("next") end, { desc = "Aerial next" })
vim.keymap.set("n", "<leader>tk", function() aerial_nav("prev") end, { desc = "Aerial prev" })
