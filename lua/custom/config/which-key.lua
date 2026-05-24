vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

require("which-key").setup({
	---@param ctx { mode: string, operator: string }
	defer = function(ctx)
		if vim.list_contains({ "d", "y" }, ctx.operator) then
			return true
		end
		return vim.list_contains({ "v", "<C-V>", "V" }, ctx.mode)
	end,
	preset = "modern",
	show_help = false,
	icons = {
		colors = true,
		keys = {
			Up = "􀄨",
			Down = "􀄩",
			Left = "􀄪",
			Right = "􀄫",
			C = "􀆍",
			M = "􀆕",
			S = "􀆝",
			CR = "􀅇",
			Esc = "􀆧",
			ScrollWheelDown = "󱕐",
			ScrollWheelUp = "󱕑",
			NL = "􀅇",
			BS = "􁂉",
			Space = "󱁐",
			Tab = "􀅂",
		},
	},
})

require("which-key").add({
	{ "g", group = "Go to", icon = "󰿅" },
	-- { '<leader>a', group = 'Avante', icon = '󰚩' },
	{ "<leader>b", group = "Buffer", icon = "" },
	-- { '<leader>d', group = 'DAP', icon = '' },
	-- { '<leader>c', group = 'DiffView', icon = '' },
	{ "<leader>q", group = "Auto-Session", icon = " " },
	{ "<leader>g", group = "Git", icon = " " },
	{ "<leader>l", group = "Lsp", mode = "n", icon = " " },
	{ "<leader>r", group = "Overseer tasks", mode = "n", icon = "󰑮 " },
	{ "<leader>f", group = "Find", mode = "n" },
	{ "<leader>t", group = "Toggle" },
	{ "<leader>tt", group = "Typst Preview", mode = "n" },
	{ "<leader>s", group = "Snacks", icon = " " },
	{ "<leader>o", group = "Opencode", icon = "󰚩 " },
	-- { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
	{ "<leader>P", group = "Picture", icon = " " },
	-- { '<leader>x', group = 'Execute Lua', icon = '', mode = { 'n', 'v' } },
})
