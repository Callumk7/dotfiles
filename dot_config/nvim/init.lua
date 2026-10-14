vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

vim.cmd "aunmenu PopUp"
vim.cmd "autocmd! nvim.popupmenu"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local lockpath = vim.fn.stdpath "config" .. "/lazy-lock.json"
	local lock = vim.fn.json_decode(table.concat(vim.fn.readfile(lockpath), "\n"))
	local lazy_commit = assert(lock["lazy.nvim"].commit, "lazy.nvim commit missing from lockfile")
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, lazypath }
	if vim.v.shell_error ~= 0 then
		error("Failed to clone lazy.nvim; bootstrap stopped")
	end
	vim.fn.system { "git", "-C", lazypath, "checkout", "--detach", lazy_commit }
	if vim.v.shell_error ~= 0 then
		error("Failed to check out locked lazy.nvim commit; bootstrap stopped")
	end
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
		config = function()
			require "options"
		end,
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require("telescope").load_extension "fzf"

vim.schedule(function()
	require "mappings"
end)

require "globals"

require "configs.conform"
