vim.opt.number = true
vim.wo.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "-" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true


vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight! link NotifyBackground NormalFloat ]])

vim.g.neovide_opacity = 0.8
vim.g.neovide_normal_opacity = 1.0

--主题

vim.keymap.set("n","<leader>L","<CMD>Lazy<CR>", { desc = "[Lazy] 打开Lazy插件管理"})


require("config.lazy")

