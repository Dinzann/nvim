vim.pack.add({
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/folke/lazydev.nvim" },
})

require("lsp.keymapping")

vim.diagnostic.config {
	virtual_text = true,
}

require("lazydev").setup({
	library = {
		{ path = "luv", types = true },
		{ path = "vim", types = true },
		{ path = "lua", types = true },
	},
})

require("mason").setup({
	ui = {
		border = "rounded",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "clangd", "ts_ls", "bashls" },
	handlers = {
		function(server_name)
			local config_path = "lsp.servers." .. server_name:gsub("-", "_")
			local ok, server_config = pcall(require, config_path)
			if ok and server_config then
				require("lspconfig")[server_name].setup(server_config)
			else
				require("lspconfig")[server_name].setup({})
			end
		end,
	},
})
