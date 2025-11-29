-- 插入模式下使用 hjkl 移动光标
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, desc = 'Move up' })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move right' })

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set({ "n", "x", "o" }, "<S-H>", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "x", "o" }, "<S-L>", "$", { desc = "End of line" })

vim.keymap.set("n", "<A-z>", "<CMD>set wrap!<CR>", { desc = "Toggle line wrap" })


