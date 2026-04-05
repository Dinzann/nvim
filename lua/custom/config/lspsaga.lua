vim.pack.add({
	{ src = "https://github.com/nvimdev/lspsaga.nvim" },
})

require("lspsaga").setup({
	ui = {
		border = "rounded",
		code_action = "",
		detail = "▎ ",
		DiagnosticVirtualText = {
			prefix = "●",
		},
		rename = {
			prefix = "➤",
			project_nvim = {
				enable = false,
			},
		},
		finder = {
			max_height = 0.3,
			split = "horizontal",
			ok = "ok",
			cancel = "cancel",
		},
		action = {
			edit = "e",
			jump = "o",
			quit = "q",
			exec = "<CR›",
		},
	},
	loader = {
		loading_text = "Loading...",
	},
	use_starter = false,
	header = false,
	code_action = {
		keys = {
			quit = "q",
			exec = "<CR›",
		},
	},
	lightbulb = {
		enable = false,
		sign = false,
		virtual_text = true,
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		show_file = true,
		folder_level = 1,
		trim_text = true,
		color_mode = false,
	},
	breadcrumb = {
		enable = true,
		symbol = " › ",
		separator = " / ",
		padding = { left = 1, right = 1 },
		color_mode = false,
	},
	progress = {
		enable = true,
		spinner = { "◜", "◠", "◝", "◞", "◡", "◟" },
		frames = { "▔", "🮕", "▀", "▄", "▁", "🮔" },
		level = { "INFO", "WARN", "ERROR" },
		align = false,
		min_priority = 0,
	},
	notification = {
		enable = false,
	},
})
