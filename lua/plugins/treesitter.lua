return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = true,
      ensure_installed = { "c", "vim", "vimdoc", "query", "elixir", "heex", "javascript", 
			 "html", "markdown", "markdown_inline", "yaml",  "typst" },
      sync_install = false,
      highlight = { enable = true,uadditional_vim_regex_highlighting = false },
      indent = { enable = true },
    },
    opts_extend = { "ensure_installed" },
  },

}
