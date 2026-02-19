-- Lazy leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spaces in tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of Python

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enable 24-bit RGB color in the TUI
vim.opt.showmode = false      -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

-- bufferline needed
vim.keymap.set('n', 'tt', '<cmd>BufferLinePick<CR>', { desc = "BufferLine: Pick" })
vim.keymap.set('n', 'th', '<cmd>BufferLineCyclePrev<CR>', { desc = "BufferLine: Left Tab" })
vim.keymap.set('n', 'tl', '<cmd>BufferLineCycleNext<CR>', { desc = "BufferLine: Right Tab" })
vim.keymap.set('n', 'tq', '<cmd>BufferLinePickClose<CR>', { desc = "BufferLine: Close Tab" })
vim.keymap.set('n', 'td', '<cmd>Bdelete<CR>', { desc = "BufferLine: Delete Tab" })

-- yazi needed
vim.g.loaded_netrwPlugin = 1
vim.keymap.set({ "n", "v" }, "<leader>bb", "<cmd>Yazi<cr>", { desc = "Buffer: Open yazi at the current file" })
vim.keymap.set("n", "<leader>bw", "<cmd>Yazi cwd<cr>", { desc = "Buffer: Open yazi in nvim's working directory" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Buffer: Resume the last yazi session" })

-- outline needed
vim.keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- bufferline needed
vim.opt.termguicolors = true

-- comment needed
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment visual" })

-- lazygit needed
vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "Git: Open Lazygit" })

-- oil needed
vim.keymap.set("n", "<leader>bo", "<cmd>Oil<CR>", { desc = "Oil: Open Oil" })

-- telescope needed
vim.keymap.set('n', '<leader>ff',"<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg',"<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb',"<cmd>Telescope buffers<CR>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh',"<cmd>Telescope help_tags<CR>", { desc = 'Telescope help tags' })
vim.keymap.set("n", '<leader>fn',"<cmd>Telescope notify<cr>", { desc = "Telescope notify history" })
