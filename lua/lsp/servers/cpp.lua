return {
	settings = {
		["*"] = {
			["editor.formatOnSave"] = false,
		},
		cpp = {
			["*"] = {
				analysis = {
					clangTidy = {
						Enabled = true,
						Checks = { "-*", "cppcoreguidelines-*", "readability-*", "performance-*", "modernize-*", "bugprone-*" },
					},
				},
			},
		},
	},
}
