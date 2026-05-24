local lz = require("lz.n")

lz.load({
	{
		-- 1. 标识符
		"codediff.nvim",

		-- 2. 指定命令触发：当你输入 :CodeDiff 时，激活整个流程
		cmd = { "CodeDiff" },

		-- 3. 对应你原来的 nargs 和 bang 参数设置
		-- 告诉 lz.n 生成代理命令时要支持参数（nargs = "*"）和感叹号（bang = true）
		opts = {
			cmd = {
				CodeDiff = { nargs = "*", bang = true },
			},
		},

		-- 4. 远程 Git 仓库源
		pack = { src = "https://github.com/esmuellert/codediff.nvim" },

		-- 5. 插件下载/载入运行时后，要执行的 setup
		after = function()
			require("codediff").setup()
		end,
	},
})
