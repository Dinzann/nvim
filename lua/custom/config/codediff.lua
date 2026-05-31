vim.pack.add({
	{ src = "https://github.com/esmuellert/codediff.nvim" },
})

local lz = require("lz.n")

lz.load({
	{
		"codediff.nvim",
		cmd = { "CodeDiff" },
		opts = {
			cmd = {
				CodeDiff = { nargs = "*", bang = true },
			},
		},
		after = function()
			require("codediff").setup()
		end,
	},
})
