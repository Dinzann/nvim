local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'mikavilpas/yazi.nvim' },
    { 'catppuccin/nvim' },
    { 'saghen/blink.cmp', dependencies = { 'rafamadriz/friendly-snippets' }, version = '1.*' },
    { 'mason-org/mason.nvim', dependencies = { 'williamboman/mason-lspconfig.nvim' } },
    { 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
    { 'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate' },
    { 'hedyhli/outline.nvim' },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', 'moll/vim-bbye' },
    { 'nvimdev/lspsaga.nvim', dependencies = 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'folke/which-key.nvim', event = 'VeryLazy' },
    { 'numToStr/Comment.nvim', lazy = false },
    { 'kdheepak/lazygit.nvim', cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" }, dependencies = 'nvim-lua/plenary.nvim' },
    { 'stevearc/oil.nvim', dependencies = "nvim-tree/nvim-web-devicons", lazy = false },
    { 'L3MON4D3/LuaSnip', version = 'v2.*', dependencies = "rafamadriz/friendly-snippets" },
    { 'goolord/alpha-nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } } },
    { 'rebelot/heirline.nvim' },
    { 'NvChad/nvim-colorizer.lua' },
    { 'rcarriga/nvim-notify', lazy = false }
})
