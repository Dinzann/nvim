local lz = require("lz.n")

lz.load({
	{
		"codediff.nvim",
		before = function()
			vim.pack.add({
				{ src = "https://github.com/esmuellert/codediff.nvim" },
			})
		end,
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
