return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	lazy = vim.fn.argc(-1) == 0,
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
	end,
	cmd = { "TSUpdate", "TSInstall" },
	config = function()
		-- Install parsers if missing
		local installed = require("nvim-treesitter.config").get_installed()
		local ensure = {
			"bash",
			"c",
			"diff",
			"html",
			"css",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"prisma",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"styled",
			"elixir",
			"heex",
			"astro",
			"java",
			"vue",
			"gleam",
			"go",
		}
		local to_install = vim.tbl_filter(function(lang)
			return not vim.tbl_contains(installed, lang)
		end, ensure)
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end
	end,
}
