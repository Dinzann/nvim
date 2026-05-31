_G.get_oil_winbar = function()
	local ok, oil = pcall(require, "balance_check_oil")
	if not ok then
		ok, oil = pcall(require, "oil")
	end

	if ok and type(oil) == "table" then
		local dir = oil.get_current_dir()
		if dir then
			return " 󰇘 " .. vim.fn.fnamemodify(dir, ":~")
		end
	end
	return ""
end

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local lz = require("lz.n")

lz.load({
	{
		"oil.nvim",
		after = function()
			package.loaded["oil"] = nil
			package.loaded["oil.config"] = nil

			local ok, oil = pcall(require, "oil")
			if not ok or type(oil) ~= "table" then
				return
			end

			local detail = false
			oil.setup({
				default_file_explorer = true,
				dependencies = { { src = "https://github.com/echasnovski/mini.icons" } },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<C-r>"] = "actions.refresh",
					["<leader>y"] = "actions.yank_entry",
					["g."] = false,
					["zh"] = "actions.toggle_hidden",
					["\\"] = { "actions.select", opts = { horizontal = true } },
					["|"] = { "actions.select", opts = { vertical = true } },
					["-"] = "actions.close",
					["q"] = "actions.close",
					["<BS>"] = "actions.parent",
					["gd"] = {
						desc = "Toggle file detail view",
						callback = function()
							detail = not detail
							if detail then
								oil.set_columns({ "icon", "permissions", "size", "mtime" })
							else
								oil.set_columns({ "icon" })
							end
						end,
					},
				},
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
			})

			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory", silent = true })
		end,
	},
})
