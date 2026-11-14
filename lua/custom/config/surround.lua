local lz = require("lz.n")

lz.load({
	{
		"mini.surround",
		before = function()
			vim.pack.add({
				{ src = "https://github.com/nvim-mini/mini.surround" },
			})
		end,
		-- flash owns `s`/`S`; use `gs*` prefix instead
		keys = {
			{ "gsa", mode = { "n", "x" }, desc = "Surround add" },
			{ "gsd", mode = { "n", "x" }, desc = "Surround delete" },
			{ "gsr", mode = { "n", "x" }, desc = "Surround replace" },
			{ "gsf", mode = { "n", "x" }, desc = "Surround find right" },
			{ "gsF", mode = { "n", "x" }, desc = "Surround find left" },
			{ "gsh", mode = { "n", "x" }, desc = "Surround highlight" },
		},
		after = function()
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "",
				},
			})
		end,
	},
})
