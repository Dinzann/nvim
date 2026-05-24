return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				-- 🎯 关键：在这里手动禁用掉这个虚警
				disable = { "param-type-mismatch" },

				-- 如果你不想让它乱报全局变量找不到（比如找不到 vim），也可以顺手加上：
				globals = {
					"vim",
					"require",
					"table",
					"string",
					"format",
					"token",
					"math",
					"type",
					"integer",
					"number",
					"ipairs",
				},
			},
			telemetry = { enabled = false },
		},
	},
}
