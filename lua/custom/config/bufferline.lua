vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
	options = {
		numbers = "ordinal",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		separator_style = "thin",
		offsets = {
			{
				filetype = "oil",
				text = "Oil",
				highlight = "Directory",
			},
		},
	},
	highlights = {
		separator = {
			fg = "#6272a4",
			bg = "#282a36",
		},
		separator_selected = {
			fg = "#6272a4",
		},
	},
})

vim.keymap.set('n', 'tt', '<cmd>BufferLinePick<CR>', { desc = "BufferLine: Pick" })
vim.keymap.set('n', 'th', '<cmd>BufferLineCyclePrev<CR>', { desc = "BufferLine: Left Tab" })
vim.keymap.set('n', 'tl', '<cmd>BufferLineCycleNext<CR>', { desc = "BufferLine: Right Tab" })
vim.keymap.set('n', 'tq', '<cmd>BufferLinePickClose<CR>', { desc = "BufferLine: Close Tab" })
-- vim.keymap.set("n", "td", "<cmd>bdelete<CR>", { desc = "BufferLine: Delete Tab" })
