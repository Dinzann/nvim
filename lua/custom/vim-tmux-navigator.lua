-- lua/setup.lua

-- 1. 禁用插件自带的默认 Ctrl 映射 (防止冲突)
vim.g.tmux_navigator_no_mappings = 1

-- 2. 手动绑定 Alt (Meta) 键位，对应你的 Tmux 配置
local nmap = function(key, cmd, desc)
    vim.keymap.set('n', key, cmd, { noremap = true, silent = true, desc = desc })
end

nmap('<C-h>', ':TmuxNavigateLeft<CR>',  '跳转到左侧面板')
nmap('<C-j>', ':TmuxNavigateDown<CR>',  '跳转到下方面板')
nmap('<C-k>', ':TmuxNavigateUp<CR>',    '跳转到上方面板')
nmap('<C-l>', ':TmuxNavigateRight<CR>', '跳转到右侧面板')

-- 如果你还需要回到上一个面板的快捷键 (可选)
nmap('<C-\\>', ':TmuxNavigatePrevious<CR>', '跳转到上一个面板')
