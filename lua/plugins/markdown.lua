return {

{ 'ryleelyman/latex.nvim', opts = {} },


{
    'MeanderingProgrammer/render-markdown.nvim',
     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
	heading = { position = 'inline' },	
	pipe_table = { preset = 'round' },
	latex = { enabled = false },
	win_options = { conceallevel = { rendered = 2 }, colorcolumn = { default = vim.o.colorcolumn, rendered = '' } }, 
	
	},
},


}
