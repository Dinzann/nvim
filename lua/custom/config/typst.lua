-- ============================================
-- 使用 vim.pack 管理插件（Neovim 0.12+）
-- ============================================

-- 添加 typst-preview.nvim 到 opt 目录（延迟加载）
vim.pack.add({
    {
        src = "https://github.com/chomosuke/typst-preview.nvim",
        type = "opt", -- 不会在启动时自动加载，需要手动 :packadd
    },
})

-- ============================================
-- 延迟加载策略
-- ============================================

local typst_group = vim.api.nvim_create_augroup('TypstPreviewLazy', { clear = true })

-- 打开 .typ 文件时自动加载插件
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = typst_group,
    pattern = '*.typ',
    callback = function()
        vim.cmd('packadd typst-preview.nvim')
        setup_typst_preview()
        -- 加载完成后清除自动命令，避免重复
        vim.api.nvim_clear_autocmds { group = typst_group }
    end,
})

-- ============================================
-- 配置函数
-- ============================================

function setup_typst_preview()
    local ok, typst_preview = pcall(require, 'typst-preview')
    if not ok then
        return
    end

    typst_preview.setup {
        debug = false,
        open_cmd = 'open -a Safari %s',
        port = 0,
        host = '127.0.0.1',
        invert_colors = 'never',
        follow_cursor = true,

        dependencies_bin = {
            tinymist = nil,
            websocat = nil,
        },

        extra_args = nil,

        get_root = function(path_of_main_file)
            local root = os.getenv 'TYPST_ROOT'
            if root then
                return root
            end
            local main_dir = vim.fs.dirname(vim.fn.fnamemodify(path_of_main_file, ':p'))
            local found = vim.fs.find({ 'typst.toml', '.git' }, { path = main_dir, upward = true })
            if #found > 0 then
                return vim.fs.dirname(found[1])
            end
            return main_dir
        end,

        get_main_file = function(path_of_buffer)
            return path_of_buffer
        end,
    }

    -- 设置快捷键
    local keymap_group = vim.api.nvim_create_augroup('TypstKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        group = keymap_group,
        pattern = 'typst',
        callback = function()
            local buf = vim.api.nvim_get_current_buf()
            vim.keymap.set('n', '<leader>tp', '<cmd>TypstPreview<CR>',
                { buffer = buf, desc = 'Toggle Typst Preview' })
            vim.keymap.set('n', '<leader>tu', '<cmd>TypstPreviewUpdate<CR>',
                { buffer = buf, desc = 'Update Typst Preview' })
            vim.keymap.set('n', '<leader>tq', '<cmd>TypstPreviewStop<CR>',
                { buffer = buf, desc = 'Stop Typst Preview' })
        end,
    })
end

-- 手动加载命令（可先于打开 .typ 文件加载插件）
vim.api.nvim_create_user_command('TypstLoad', function()
    vim.cmd('packadd typst-preview.nvim')
    setup_typst_preview()
end, {})
