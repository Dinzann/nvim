if vim.env.TMUX ~= nil and vim.env.TMUX ~= "" then
	-- only normal-mode maps; insert-mode <C-hjkl> stay for cursor movement
	vim.g.tmux_navigator_no_mappings = 1
	vim.pack.add({
		"https://github.com/christoomey/vim-tmux-navigator",
	})

	-- tell tmux this pane is nvim (ps-based detection is unreliable on macOS)
	local function set_pane_is_vim(enabled)
		vim.system({ "tmux", "set-option", "-p", "@pane-is-vim", enabled and "1" or "0" })
	end
	vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "DirChanged" }, {
		callback = function()
			set_pane_is_vim(true)
		end,
	})
	vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
		callback = function()
			set_pane_is_vim(false)
		end,
	})
	set_pane_is_vim(true)

	local opts = { silent = true }
	vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
	vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
	vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
	vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
else
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
end
