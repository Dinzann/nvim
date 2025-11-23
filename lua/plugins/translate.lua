return {
	"uga-rosa/translate.nvim",
	config = function()
		vim.api.nvim_set_keymap('n', 'tr', "viw:Translate ZH -output=replace<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('v', 'tr', ":'<,'>Translate ZH -output=replace<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', 'ts', "viw:Translate ZH<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('v', 'ts', ":'<,'>Translate ZH<CR>",
			{ noremap = true, silent = true })
		require("translate").setup({
			default = {
				command = "translate_shell",
			},
			preset = {
				command = {
					translate_shell = {
						args = { "-e", "bing" }
					}
				}
			}
		})
	end
}

