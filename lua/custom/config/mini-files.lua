vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("SetupMiniFiles", { clear = true }),
  once = true,
  pattern = "MiniFilesLazy",
  callback = function()
    vim.pack.add({
      { src = "https://github.com/nvim-mini/mini.files" },
    })

    require("mini.files").setup({
      mappings = {
        close       = "q",
        go_in       = "l",
        go_in_plus  = "L",
        go_out      = "h",
        go_out_plus = "H",
        mark_goto   = "'",
        mark_set    = "m",
        reset       = "<BS>",
        reveal_cwd  = "@",
        show_help   = "g?",
        synchronize = "=",
        trim_left   = "<",
        trim_right  = ">",
      },

      options = {
        permanent_delete = true,
        use_as_default_explorer = false,
        lsp_timeout = 1000,
      },

      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 60,
        width_nofocus = 20,
        width_preview = 50,
      },
    })
  end,
})

vim.keymap.set("n", "-", function()
  vim.api.nvim_exec_autocmds("User", { pattern = "MiniFilesLazy" })

  local MiniFiles = require("mini.files")

  if MiniFiles.close() then return end

  MiniFiles.open(vim.fn.expand("%:p:h"))
end, { desc = "Toggle mini.files" })
