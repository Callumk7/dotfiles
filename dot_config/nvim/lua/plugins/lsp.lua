return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require "configs.lspconfig"
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup {
				scroll_preview = {
					scroll_down = "<C-f>",
					scroll_up = "<C-d>",
				},
				ui = {
					title = false,
					border_style = "rounded",
				},
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
			}
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				biome = {
					require_cwd = true,
				},
				deno_fmt = {
					cwd = require("conform.util").root_file { "deno.json" },
					require_cwd = true,
				},
			},
			formatters_by_ft = {
				javascript = { "biome", "prettierd", stop_after_first = true },
				typescript = { "biome", "deno_fmt", "prettierd", stop_after_first = true },
				javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd" },
				html = { "biome", "prettierd", stop_after_first = true },
				astro = { "prettierd" },
				json = { "biome", "prettierd", stop_after_first = true },
				rust = { "rustfmt" },
				go = { "gofmt" },
				sh = { "shfmt" },
				ruby = { "rubyfmt" },
				gleam = { "gleam" },
			},
		},
	},
}
