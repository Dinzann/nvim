vim.pack.add({
   { src = "https://github.com/mikavilpas/yazi.nvim" },
   -- { src = "https://github.com/nvim-lua/plenary.nvim" }
})

require("yazi").setup({
    open_for_directories = false,
    keymaps = {
        show_help = "<f1>",
    },
})

vim.g.loaded_netrwPlugin = 1
vim.keymap.set({ "n", "v" }, "<leader>bb", "<cmd>Yazi<cr>", { desc = "Buffer: Open yazi at the current file" })
vim.keymap.set("n", "<leader>bw", "<cmd>Yazi cwd<cr>", { desc = "Buffer: Open yazi in nvim's working directory" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Buffer: Resume the last yazi session" })
