pcall(vim.cmd, "packadd blink.lib")

local lz = require("lz.n")

lz.load({
	-- 1. LuaSnip 独立加载
	{
		"LuaSnip",
		pack = { src = "https://github.com/L3MON4D3/LuaSnip" },
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- 2. 静态代码片段资源包
	{
		"friendly-snippets",
		pack = { src = "https://github.com/rafamadriz/friendly-snippets" },
		event = { "InsertEnter", "CmdlineEnter" },
	},

	-- 3. 图标插件独立加载
	{
		"mini.icons",
		pack = { src = "https://github.com/echasnovski/mini.icons" },
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("mini.icons").setup()
		end,
	},

	-- 4. 核心补全插件（此时底层 rtp 早就准备好了）
	{
		"blink.cmp",
		pack = { src = "https://github.com/saghen/blink.cmp" },
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("blink.cmp").setup({
				fuzzy = { implementation = "lua" },
				keymap = {
					preset = "enter",
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "snippet_forward", "fallback" },
					["<S-Tab>"] = { "snippet_backward", "fallback" },
				},
				completion = {
					list = {
						selection = { preselect = false, auto_insert = true },
					},
					menu = {
						scrollbar = true,
						border = "none",
						draw = {
							treesitter = { "lsp" },
							columns = {
								{ "kind_icon", gap = 1 },
								{ "label", "label_description", gap = 1 },
								{ "source_name" },
							},
							components = {
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
										return icon
									end,
									highlight = function(ctx)
										local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
										return hl
									end,
								},
								source_name = {
									text = function(ctx)
										local labels = {
											lsp = "LSP",
											snippets = "Snip",
											buffer = "Buf",
											path = "Path",
											codeium = "AI",
										}
										local name = labels[ctx.source_id] or ctx.source_name
										return "[" .. name .. "]"
									end,
									highlight = "NonText",
								},
							},
						},
					},
					trigger = {
						show_on_backspace = true,
						prefetch_on_insert = false,
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 100,
						window = { border = "rounded" },
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				cmdline = {
					completion = {
						menu = { auto_show = true },
					},
				},
				snippets = { preset = "luasnip" },
				signature = { enabled = true, window = { border = "rounded" } },
			})
		end,
	},
})
