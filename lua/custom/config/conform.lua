local lz = require("lz.n")

lz.load({
	"conform.nvim",
	pack = { src = "https://github.com/stevearc/conform.nvim" },
	event = { "BufWritePre" },
	keys = { { "<leader>lf", desc = "Format buffer" } },
	after = function()
		-- 🎯 绝杀清除缓存：强行抹去可能存在的布尔值代理，逼迫 Lua 重新去磁盘找真的文件
		package.loaded["conform"] = nil
		package.loaded["conform.init"] = nil

		-- 🎯 终极防御：如果 require 出来还是布尔值，说明彻底卡在时序里，用底层全路径直接捞
		local ok, conform = pcall(require, "conform")
		if not ok or type(conform) ~= "table" then
			-- 降级方案：直接加载它的核心主入口文件
			conform = dofile(vim.api.nvim_get_runtime_file("lua/conform/init.lua", false)[1])
		end

		-- 如果连 dofile 都没捞到（极端情况），直接安全退出，不卡死 init
		if type(conform) ~= "table" then
			return
		end

		-- 后面就是你原本的 setup 逻辑，稳如泰山
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				rust = { "rustfmt", lsp_format = "fallback" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				sh = { "shfmt" },
				bash = { "shfmt" },
				["_"] = { "lsp_format" },
			},
			format_on_save = {
				timeout_ms = 1500,
				lsp_format = "fallback",
			},
		})

		vim.keymap.set("n", "<leader>lf", function()
			-- 快捷键内部也可以做一层安全 require
			local has_c, c = pcall(require, "conform")
			if has_c and type(c) == "table" then
				c.format({ async = true, lsp_format = "fallback" })
			end
		end, { desc = "Format buffer" })
	end,
})
