---@diagnostic disable: missing-return
vim.api.nvim_create_autocmd("User", {
	pattern = "LoadComment",
    group = vim.api.nvim_create_augroup("LoadComment", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/numToStr/Comment.nvim" },
        })
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
			pre_hook = function()
			end,
			post_hook = function()
			end,
		})
        vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
        vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment visual" })
    end,
})
vim.keymap.set("n", "<leader>/", function()
    vim.api.nvim_exec_autocmds("User", { pattern = "LoadComment" })
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gcc", true, false, true), "n", true)
end, { desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", function()
    vim.api.nvim_exec_autocmds("User", { pattern = "LoadComment" })
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gc", true, false, true), "n", true)
end, { desc = "Toggle comment visual" })
