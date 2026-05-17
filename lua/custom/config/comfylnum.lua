local configured = false

local function load_comfylnum()
    if configured then
        return
    end

    configured = true
    vim.pack.add({
        { src = "https://github.com/mluders/comfy-line-numbers.nvim" },
    })

    require("comfy-line-numbers").setup()

    if vim.bo.filetype == "snacks_dashboard" then
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.statuscolumn = ""
        vim.opt_local.signcolumn = "no"
    end
end

vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("LoadComfyLineNumbers", { clear = true }),
    once = true,
    callback = function()
        vim.schedule(load_comfylnum)
    end,
})
