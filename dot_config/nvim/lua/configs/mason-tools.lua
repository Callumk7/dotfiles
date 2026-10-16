-- Shared baseline only. Install additional machine-specific tools through :Mason.
-- Tools are installed explicitly with :MasonToolsInstall, never at startup.
return {
	ensure_installed = {
		-- Lua
		"lua-language-server",
		"stylua",
		-- HTML, CSS, JSON, TypeScript/JavaScript, and Tailwind
		"html-lsp",
		"css-lsp",
		"json-lsp",
		"typescript-language-server",
		"tailwindcss-language-server",
		-- Formatting
		"biome",
		"prettier",
		"shfmt",
		-- Bash and Elixir
		"bash-language-server",
		"elixir-ls",
	},
	run_on_start = false,
	auto_update = false,
	-- Use Mason package names directly, regardless of optional integrations.
	integrations = {
		["mason-lspconfig"] = false,
		["mason-null-ls"] = false,
		["mason-nvim-dap"] = false,
	},
}
