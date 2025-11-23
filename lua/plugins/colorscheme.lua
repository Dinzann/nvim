return {
   {
   "zaldih/themery.nvim",
     lazy = false,
     config = function()
       require("themery").setup({
        themes = {
        -- 在此列表中添加你想要管理的主题
        { name = " Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
        { name = " Catppuccin Frappé", colorscheme = "catppuccin-frappe" },
        { name = " Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
        { name = " Catppuccin Latte", colorscheme = "catppuccin-latte" },
        { name = " Vague", colorscheme = "vague" },
        { name = " Gruvbox Dark", colorscheme = "gruvbox",before = [[vim.o.background = 'dark']] },
        { name = " Gruvbox Light", colorscheme = "gruvbox",before = [[vim.o.background = 'light']] },
        { name = "󱩅 kanagawa-wave", colorscheme = "kanagawa-wave" },
        { name = " kanagawa-dragon", colorscheme = "kanagawa-dragon" },
        { name = " kanagawa-lotus", colorscheme = "kanagawa-lotus" },
                -- 继续添加更多主题...
          },
        livePreview = true,
                                                                                            f
       })

      --Binds
      vim.keymap.set("n", "<leader>ggt", ":Themery<CR>", { desc = "Open Themery theme selector", noremap = true, silent = true })

     end,
   },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      custom_highlights = function(colors)
        -- stylua: ignore
        return {
          LineNr     = { fg = colors.surface2 },
          Visual     = { bg = colors.overlay0 },
          Search     = { bg = colors.surface2 },
          IncSearch  = { bg = colors.mauve },
          CurSearch  = { bg = colors.mauve },
          MatchParen = { bg = colors.mauve, fg = colors.base, bold = true },
        }
      end,
      integrations = {
        barbar = true,
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        noice = true,
        nvimtree = true,
        rainbow_delimiters = true,
        snacks = {
          enabled = true,
          indent_scope_color = "flamingo", -- catppuccin color (eg. `lavender`) Default: text
        },
        which_key = true,
        flash = true,
        lsp_trouble = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin")
    end,
  },

{
  "vague-theme/vague.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other plugins
  config = function()
    -- NOTE: you do not need to call setup if you don't want to.
   require("vague").setup({
  transparent = false, -- don't set background
  -- disable bold/italic globally in `style`
  bold = true,
  italic = true,
  style = {
    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
    boolean = "bold",
    number = "none",
    float = "none",
    error = "bold",
    comments = "italic",
    conditionals = "none",
    functions = "none",
    headings = "bold",
    operators = "none",
    strings = "italic",
    variables = "none",

    -- keywords
    keywords = "none",
    keyword_return = "italic",
    keywords_loop = "none",
    keywords_label = "none",
    keywords_exception = "none",

    -- builtin
    builtin_constants = "bold",
    builtin_functions = "none",
    builtin_types = "bold",
    builtin_variables = "none",
  },
  -- plugin styles where applicable
  -- make an issue/pr if you'd like to see more styling options!
  plugins = {
    cmp = {
      match = "bold",
      match_fuzzy = "bold",
    },
    dashboard = {
      footer = "italic",
    },
    lsp = {
      diagnostic_error = "bold",
      diagnostic_hint = "none",
      diagnostic_info = "italic",
      diagnostic_ok = "none",
      diagnostic_warn = "bold",
    },
    neotest = {
      focused = "bold",
      adapter_name = "bold",
    },
    telescope = {
      match = "bold",
    },
  },

  -- Override highlights or add new highlights
  on_highlights = function(highlights, colors) end,

  -- Override colors
  colors = {
    bg = "#141415",
    inactiveBg = "#1c1c24",
    fg = "#cdcdcd",
    floatBorder = "#878787",
    line = "#252530",
    comment = "#606079",
    builtin = "#b4d4cf",
    func = "#c48282",
    string = "#e8b589",
    number = "#e0a363",
    property = "#c3c3d5",
    constant = "#aeaed1",
    parameter = "#bb9dbd",
    visual = "#333738",
    error = "#d8647e",
    warning = "#f3be7c",
    hint = "#7e98e8",
    operator = "#90a0b5",
    keyword = "#6e94b2",
    type = "#9bb4bc",
    search = "#405065",
    plus = "#7fa563",
    delta = "#f3be7c",
  },
})
       vim.cmd("colorscheme vague")
  end
},

{
"ellisonleao/gruvbox.nvim",
  priority = 1000, -- 确保主题在其他插件之前加载
  config = function()
    -- 在这里设置主题的配置项
    require("gruvbox").setup({
      italic = {
        strings = false, -- 字符串不使用斜体
        comments = true, -- 注释使用斜体
        operators = false,
        folds = true,
      },
      contrast = "soft", -- 可选值: "hard", "soft", ""(空字符串)
    })

    -- 立即应用主题
    --vim.o.background = "dark" -- 或 "light" 用于浅色模式[citation:1][citation:5]
    vim.cmd("colorscheme gruvbox")
  end,
},

{
"rebelot/kanagawa.nvim",
  priority = 1000, -- 确保主题优先加载，避免界面闪烁[citation:1]
  config = function()
    require('kanagawa').setup({
        -- 此处可添加 Kanagawa 的自定义配置
        -- 例如，设置默认变体为 "wave"
        -- variant = "wave",
        -- 其他配置选项...
    })

    -- 立即应用主题[citation:1]
    vim.cmd("colorscheme kanagawa-wave")
    vim.cmd("colorscheme kanagawa-dragon")
    vim.cmd("colorscheme kanagawa-lotus")

  end,
},

}


