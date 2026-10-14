local pnpm_root = vim.fn.system("pnpm root -g"):gsub("\n", "")
local vue_typescript_plugin_path = vim.fs.normalize(pnpm_root .. "/../.pnpm/node_modules")

-- servers with default config
local servers = {
	"html",
	"cssls",
	"bashls",
	"astro",
	"eslint",
	"jsonls",
	"gopls",
	"gleam",
	"pyright",
	"svelte",
	"markdown_oxide",
	"taplo",
	"ruby_lsp",
	"rust_analyzer",
	"jdtls",
}
vim.lsp.enable(servers)

-- typescript
vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin_path,
				languages = { "vue" },
				configNamespace = "typescript",
			},
		},
	},
	root_markers = { "package.json" },
	workspace_required = true,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- tailwindcss
vim.lsp.config("tailwindcss", {
	root_markers = { "package.json", "mix.exs", ".git" },
	filetypes = {
		"html",
		"heex",
		"eelixir",
		"css",
		"scss",
		"javascript",
		"typescript",
		"vue",
		"svelte",
		"javascriptreact",
		"typescriptreact",
	},
	settings = {
		tailwindCSS = {
			lint = {
				cssConflict = "ignore",
			},
			experimental = {
				classRegex = {
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				},
			},
			includeLanguages = { heex = "html", eelixir = "html" },
		},
	},
	on_attach = function(_, bufnr)
		vim.lsp.document_color.enable(false, { bufnr = bufnr })
	end,
})

-- biome
vim.lsp.config("biome", {
	root_markers = { "biome.json" },
	workspace_required = true,
})

-- deno (should only trigger with deno root file)
vim.lsp.config("denols", {
	root_markers = { "deno.json" },
	workspace_required = true,
	cmd_env = { NO_COLOR = false },
})

-- omnisharp
vim.lsp.config("omnisharp", {
	cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true,
			OrganizeImports = true,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableImportCompletion = true,
		},
	},
})

-- elixir
vim.lsp.config("elixirls", {
	cmd = { vim.fn.stdpath "data" .. "/mason/packages/elixir-ls/language_server.sh" },
})

-- enable all custom servers
vim.lsp.enable { "ts_ls", "vue_ls", "tailwindcss", "biome", "denols", "omnisharp", "elixirls" }

-- Deno has some stupid semantic token highlighting built into
-- the LSP, so we need to lower the priority of that
vim.highlight.priorities.semantic_tokens = 95

-- Come write OCaml with me
vim.lsp.config["ocamllsp"] = {
	cmd = { "ocamllsp" },
	filetypes = {
		"ocaml",
		"ocaml.interface",
		"ocaml.menhir",
		"ocaml.ocamllex",
		"dune",
		"reason",
	},
	root_markers = {
		{ "dune-project", "dune-workspace" },
		{ "*.opam", "esy.json", "package.json" },
		".git",
	},
	settings = {},
}

vim.lsp.enable "ocamllsp"
