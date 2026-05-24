vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/zaldih/themery.nvim" },
})

require("mini.icons").setup()

require("custom.colorscheme.catppuccin")
require("custom.colorscheme.rose-pine")
require("custom.colorscheme.nordic")

require("themery").setup({
	themes = { "catppuccin", "rose-pine-moon", "nordic" },
	livePreview = true,
})
