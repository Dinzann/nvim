local status, notify = pcall(require, "notify")
if not status then
    return
end

notify.setup({
    stages = "fade",
    render = "compact",
    background_colour = "#000000",
    timeout = 3000,
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
})

vim.notify = notify

pcall(require('telescope').load_extension, 'notify')
