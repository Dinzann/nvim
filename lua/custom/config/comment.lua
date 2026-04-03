---@diagnostic disable: missing-return
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
