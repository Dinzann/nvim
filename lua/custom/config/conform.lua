vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

local lz = require("lz.n")

lz.load({
	"conform.nvim",
	event = { "BufWritePre" },
	keys = { { "<leader>lf", desc = "Format buffer" } },
	after = function()
		package.loaded["conform"] = nil
		package.loaded["conform.init"] = nil

		local ok, conform = pcall(require, "conform")
		if not ok or type(conform) ~= "table" then
			conform = dofile(vim.api.nvim_get_runtime_file("lua/conform/init.lua", false)[1])
		end

		if type(conform) ~= "table" then
			return
		end

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
