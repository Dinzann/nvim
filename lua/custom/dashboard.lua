require('alpha').setup(require('alpha.themes.dashboard').config)

require("alpha.themes.dashboard").config.layout[2].val = require("utils.logo").din

require("alpha.themes.dashboard").section.buttons.val = {
    require("alpha.themes.dashboard").button("f", "󰈞  Find File", ":Telescope find_files <CR>"),
    require("alpha.themes.dashboard").button("g", "󰊄  Live Grep", ":Telescope live_grep <CR>"),
    require("alpha.themes.dashboard").button("r", "󰄉  Recent Files", ":Telescope oldfiles <CR>"),
    require("alpha.themes.dashboard").button("e", "󰙅  New File", ":ene <BAR> startinsert <CR>"),
    require("alpha.themes.dashboard").button("c", "  Config", ":e $MYVIMRC <CR>"),
    require("alpha.themes.dashboard").button("L", "󰒲  Lazy", ":Lazy<CR>"),
    require("alpha.themes.dashboard").button("q", "󰅚  Quit", ":qa<CR>"),
}

-- foot Lazy time show
require("alpha.themes.dashboard").section.footer.val = "󱐌 Loaded " .. require("lazy").stats().count .. " plugins"
require("alpha.themes.dashboard").section.footer.opts.hl = "AlphaFooter"

local quotes = {
    "󱌲  Stay hungry, stay foolish.",
    "󱌲  Talk is cheap. Show me the code.",
    "󱌲  Hello World, Hello Dinzann.",
    "󱌲  Code is like humor. When you have to explain it, it’s bad.",
    "󱌲  First, solve the problem. Then, write the code.",
    "󱌲  The only way to do great work is to love what you do.",
}

math.randomseed(os.time())
local random_quote = quotes[math.random(#quotes)]

local stats = require("lazy").stats()

require("alpha.themes.dashboard").section.footer.val = {
    "󱐌 Loaded " .. stats.count .. " plugins",
    "",
    random_quote,
}
require("alpha.themes.dashboard").section.footer.opts.hl = "AlphaFooter"
