require "nvchad.options"

local autocmd = vim.api.nvim_create_autocmd
local usrcmd = vim.api.nvim_create_user_command
local opt = vim.opt
local hl = vim.api.nvim_set_hl

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.relativenumber = true

opt.ignorecase = true
opt.smartcase = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})

-- Remove keymaps (from NvChad)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.schedule(function()
			vim.keymap.del("n", "<C-c>")
		end)
	end,
})

--snippets
require("luasnip.loaders.from_vscode").lazy_load { paths = "~/.config/nvim/snippets" }

-- highlight customisations

-- TS utility
usrcmd("TSHighlightCapturesUnderCursor", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, {})

-- auto-remove unused imports when saving a file
usrcmd("RemoveUnusedImports", function()
	vim.lsp.buf.code_action {
		apply = true,
		context = {
			only = { "source.removeUnusedImports.ts" },
			diagnostics = {},
		},
	}
end, {})

-- highlights
hl(0, "FlashLabel", { fg = "#0f0f14", bg = "#ff9e64" })

-- set markdown highlight for mdx file
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.mdx" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
	end,
})

-- Restore cursor position on open
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line "'\""
		if
			line > 1
			and line <= vim.fn.line "$"
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd 'normal! g`"'
		end
	end,
})

-- Autlolocking zellij
local function zellij(mode)
	vim.schedule(function()
		if vim.env.ZELLIJ ~= nil then
			vim.fn.system { "zellij", "action", "switch-mode", mode }
		end
	end)
end

autocmd({ "FocusGained", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("zellij_lock", {}),
	callback = function()
		zellij "locked"
	end,
})

autocmd({ "FocusLost", "VimLeave" }, {
	group = vim.api.nvim_create_augroup("zellij_normal", {}),
	callback = function()
		zellij "normal"
	end,
})

autocmd("FileType", {
	desc = "Automatically Split help Buffers to the right",
	pattern = "help",
	command = "wincmd L",
})

-- Swap Ctrl and Alt keys
-- vim.schedule(function()
-- 	local modes = { "n", "v", "i", "s", "x", "o" }
--
-- 	-- Loop through all lowercase letters a-z
-- 	for char_code = 97, 122 do
-- 		local char = string.char(char_code)
--
-- 		-- Map <A-char> to <C-char>
-- 		-- e.g., when you press Alt-x, Neovim will execute the Ctrl-x behavior
-- 		vim.keymap.set(
-- 			modes,
-- 			"<A-" .. char .. ">",
-- 			"<C-" .. char .. ">",
-- 			{ noremap = true, silent = true, desc = "Swap Alt-key with Ctrl-key" }
-- 		)
--
-- 		-- Map <C-char> to <A-char>
-- 		-- e.g., when you press Ctrl-x, Neovim will execute the Alt-x behavior
-- 		vim.keymap.set(
-- 			modes,
-- 			"<C-" .. char .. ">",
-- 			"<A-" .. char .. ">",
-- 			{ noremap = true, silent = true, desc = "Swap Ctrl-key with Alt-key" }
-- 		)
-- 	end
-- end)

autocmd("FileType", {
	pattern = "qf",
	callback = function()
		-- Remap <Enter> in normal mode to open the item under the cursor and close the quickfix window
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = true, nowait = true })
	end,
})
