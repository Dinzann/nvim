local lz = require("lz.n")

lz.load({
	{
		"auto-session",
		before = function()
			vim.pack.add({
				{ src = "https://github.com/rmagatti/auto-session" },
			})
		end,
		event = { "VimEnter" },

		after = function()
			package.loaded["auto-session"] = nil

			local ok, auto_session = pcall(require, "auto-session")
			if not ok or type(auto_session) ~= "table" then
				return
			end

			auto_session.setup({
				auto_restore = true,
				auto_save = true,
				suppressed_dirs = {
					"~/",
					"/",
					"~/Downloads",
					"~/Desktop",
					"/tmp",
				},
				bypass_save_filetypes = {
					"oil",
					"aerial",
					"lazy",
					"mason",
					"notify",
					"qf",
				},
				auto_restore_last_session = false, -- 禁用全局最后的会话，只认当前项目路径
			})
			vim.keymap.set("n", "<leader>qs", "<cmd>AutoSession save<cr>", { desc = "Save session" })
			vim.keymap.set("n", "<leader>qr", "<cmd>AutoSession restore<cr>", { desc = "Restore session" })
			vim.keymap.set("n", "<leader>qd", "<cmd>AutoSession delete<cr>", { desc = "Delete current session" })
		end,
	},
})
