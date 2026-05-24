local lz = require("lz.n")

lz.load({
	{
		"auto-session",
		pack = { src = "https://github.com/rmagatti/auto-session" },
		-- 🎯 关键时机：在进入 Neovim 且 UI 渲染完毕（或读取缓冲区）时加载
		-- 这样能确保打开目录或文件时，立刻无缝恢复上一次的会话状态
		event = { "VimEnter" },

		after = function()
			package.loaded["auto-session"] = nil

			local ok, auto_session = pcall(require, "auto-session")
			if not ok or type(auto_session) ~= "table" then
				return
			end

			auto_session.setup({
				-- 1. 🎯 核心行为：进门自动恢复，出门自动保存
				auto_restore = true,
				auto_save = true,

				-- 2. 🎯 安全沙盒：哪些地方绝对不要自动保存会话
				-- 比如直接在系统根目录、家目录、或者临时/下载目录里瞎晃悠时，不要生成垃圾会话
				suppressed_dirs = {
					"~/",
					"/",
					"~/Downloads",
					"~/Desktop",
					"/tmp",
				},

				-- 3. 🎯 净化视图：哪些敏感/临时窗口不要被录进会话里
				-- 这样可以确保下次恢复会话时，不会残留一堆破碎的插件窗口（比如 Oil 或临时浮窗）
				bypass_save_filetypes = {
					"oil",
					"aerial",
					"lazy",
					"mason",
					"notify",
					"qf",
				},

				-- 4. 🎯 原生完美契合：当你用系统的 `nvim .` 打开目录时
				-- 优先让它去检测并恢复当前目录的会话，而不是弹出一个空目录
				auto_restore_last_session = false, -- 禁用全局最后的会话，只认当前项目路径

				-- 5. 🎯 状态栏/Winbar 联动（可选）
				-- 会话保存的根路径，默认是 ~/.local/share/nvim/sessions/
				-- 保持默认即可，不需要像普通管理器那样满项目乱拉屎
			})

			-- 🎯 极其克制的原生快捷键绑定（不抢占常用键）
			-- <leader>qs (Session Save) / <leader>qr (Session Restore) / <leader>qd (Session Delete)
			vim.keymap.set("n", "<leader>qs", "<cmd>AutoSession save<cr>", { desc = "Save session" })
			vim.keymap.set("n", "<leader>qr", "<cmd>AutoSession restore<cr>", { desc = "Restore session" })
			vim.keymap.set("n", "<leader>qd", "<cmd>AutoSession delete<cr>", { desc = "Delete current session" })
		end,
	},
})
