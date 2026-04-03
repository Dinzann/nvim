return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				library = {
					vim.fn.fnamemodify(vim.fn.stdpath("config"), ":p") .. "lua",
				},
				checkThirdParty = false,
			},
			diagnostics = {
				disable = { "deprecated" },
			},
			telemetry = { enable = false },
		},
	},
}
