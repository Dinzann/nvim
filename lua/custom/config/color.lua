vim.pack.add({
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
})

require("colorizer").setup({
	filetypes = { "*" },
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = true,
		RRGGBBAA = true,
		AARRGGBB = true,
		rgb_fn = true,
		hsl_fn = true,
		css = true,
		css_fn = true,
		mode = "virtualtext",
		virtualtext = "󱓻 ",
		virtualtext_inline = true,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.cmd("ColorizerAttachToBuffer")
	end,
})
