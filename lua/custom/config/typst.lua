local lz = require("lz.n")

lz.load({
    {
        "typst-preview.nvim",
        before = function()
            vim.pack.add({
                { src = "https://github.com/chomosuke/typst-preview.nvim" },
            })
        end,
        ft = "typst",
        cmd = "TypstPreview",
        after = function()
            require("typst-preview").setup({
                debug = false,
                open_cmd = "open -a Safari %s",
                port = 0,
                host = "127.0.0.1",
                invert_colors = "never",
                follow_cursor = true,
                dependencies_bin = {
                    tinymist = nil,
                    websocat = nil,
                },
                extra_args = nil,
                get_root = function(path_of_main_file)
                    local root = os.getenv("TYPST_ROOT")
                    if root then
                        return root
                    end
                    local main_dir = vim.fs.dirname(vim.fn.fnamemodify(path_of_main_file, ":p"))
                    local found = vim.fs.find({ "typst.toml", ".git" }, { path = main_dir, upward = true })
                    if #found > 0 then
                        return vim.fs.dirname(found[1])
                    end
                    return main_dir
                end,
                get_main_file = function(path_of_buffer)
                    return path_of_buffer
                end,
            })

            local buf = vim.api.nvim_get_current_buf()
            if vim.bo[buf].filetype == "typst" then
                vim.keymap.set("n", "<leader>ttp", "<cmd>TypstPreview<CR>",
                    { buffer = buf, desc = "Toggle Typst Preview" })
                vim.keymap.set(
                    "n",
                    "<leader>ttu",
                    "<cmd>TypstPreviewUpdate<CR>",
                    { buffer = buf, desc = "Update Typst Preview" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>ttq",
                    "<cmd>TypstPreviewStop<CR>",
                    { buffer = buf, desc = "Stop Typst Preview" }
                )
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TypstKeymaps", { clear = true }),
                pattern = "typst",
                callback = function()
                    local abuf = vim.api.nvim_get_current_buf()
                    vim.keymap.set(
                        "n",
                        "<leader>ttp",
                        "<cmd>TypstPreview<CR>",
                        { buffer = abuf, desc = "Toggle Typst Preview" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ttu",
                        "<cmd>TypstPreviewUpdate<CR>",
                        { buffer = abuf, desc = "Update Typst Preview" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ttq",
                        "<cmd>TypstPreviewStop<CR>",
                        { buffer = abuf, desc = "Stop Typst Preview" }
                    )
                end,
            })
        end,
    },
})
