-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`
local custom_utils = require("custom.utils")

local function augroup(name)
    return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- 1. Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "CurSearch" })
    end,
})

-- 2. Restore cursor position
-- 使用 silent! 避免在无法定位的文件（如新文件）中报错
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_exec2('silent! normal! g`"zv', { output = false })
    end,
})

-- 3. Big file detection and handling
-- 修复核心：设置默认阈值并防止递归调用
vim.g.bigfile_size = vim.g.bigfile_size or (1024 * 1024) -- 默认 1MB
local checking_bigfile = false

vim.filetype.add {
    pattern = {
        ['.*'] = {
            priority = -1,
            function(path, buf)
                -- 防御性检查：确保 path 存在且未在递归检测中
                if checking_bigfile or not path or path == "" or not vim.api.nvim_buf_is_valid(buf) then
                    return nil
                end

                local size = vim.fn.getfsize(path)
                -- 核心修复：防止与 nil 比较
                if size > (vim.g.bigfile_size or 1048576) then
                    return 'bigfile'
                end
                return nil
            end,
        },
    },
}

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup 'bigfile',
    pattern = 'bigfile',
    callback = function(ev)
        vim.b.minianimate_disable = true
        -- 大文件禁用 cursorline 以提升滚动性能
        vim.opt_local.cursorline = false
        
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(ev.buf) then return end
            
            -- 开启锁，防止再次进入上面的 bigfile 检测函数
            checking_bigfile = true
            local actual_ft = vim.filetype.match { buf = ev.buf }
            checking_bigfile = false
            
            if actual_ft and actual_ft ~= 'bigfile' then
                vim.bo[ev.buf].syntax = actual_ft
            end
        end)
    end,
})

-- 4. Terminal settings
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- 5. Irreplaceable Windows (Fixed buffers)
vim.api.nvim_create_augroup('IrreplaceableWindows', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = 'IrreplaceableWindows',
    pattern = '*',
    callback = function()
        local filetypes = { 'OverseerList', 'neo-tree' }
        local buftypes = { 'nofile', 'terminal' }
        if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
            vim.cmd 'set winfixbuf'
        end
    end,
})

-- 6. Window Resizing handling
vim.api.nvim_create_autocmd('VimResized', {
    pattern = '*',
    callback = function()
        -- Equalize window sizes
        vim.cmd 'wincmd =' 

        -- DAP UI reset
        custom_utils.func_on_window('dapui_stacks', function()
            require 'dapui'.open({ reset = true })
        end)

        -- OverseerList reset
        custom_utils.reset_overseerlist_width()
    end,
})

-- 7. Quickfix window specific settings
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        -- Ensure <CR> works in quickfix
        vim.keymap.set('n', '<CR>', '<CR>', { buffer = true, desc = 'Default Enter in quickfix' })
        -- Enable cursorline for better visibility
        vim.opt_local.cursorline = true
    end,
})

-- 8. Custom Commands
vim.api.nvim_create_user_command("FCN", function()
  vim.cmd("silent! vimgrep /FCN=/gj %")
  vim.cmd("copen")
end, { desc = "Search for FCN= in current buffer" })
