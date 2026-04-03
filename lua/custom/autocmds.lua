local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "CurSearch" })
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec2("silent! normal! g`\"zv'", { output = false })
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("custom-term", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

vim.api.nvim_create_augroup("IrreplaceableWindows", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "IrreplaceableWindows",
	pattern = "*",
	callback = function()
		local filetypes = { "OverseerList", "neo-tree" }
		local buftypes = { "nofile", "terminal" }
		if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
			vim.cmd("set winfixbuf")
		end
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	group = augroup("resize"),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	group = augroup("quickfix"),
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = true, desc = "Default Enter in quickfix" })
		vim.opt_local.cursorline = true
	end,
})
