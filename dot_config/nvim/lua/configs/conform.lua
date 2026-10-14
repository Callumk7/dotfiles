--type conform.options
local options = {
	formatters = {
		biome = {
			require_cwd = true,
		},
		deno_fmt = {
			cwd = require("conform.util").root_file { "deno.json" },
			require_cwd = true,
		},
	},
	timeout_ms = 150000,
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome", "prettier", stop_after_first = true },
		typescript = { "biome", "deno_fmt", "prettier", stop_after_first = true },
		javascriptreact = { "biome", "prettier", stop_after_first = true },
		typescriptreact = { "biome", "prettier", stop_after_first = true },
		vue = { "prettier", stop_after_first = true },
		css = { "biome", "prettier", stop_after_first = true },
		html = { "biome", "prettier", stop_after_first = true },
		markdown = { "prettier" },
		json = { "biome", "prettier", stop_after_first = true },
		rust = { "rustfmt" },
		go = { "gofmt" },
		sh = { "shfmt" },
		astro = { "prettier" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 150000,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
vim.notify("Config file loaded successfully!", vim.log.levels.INFO)
