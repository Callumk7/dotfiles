return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return {
				override = require "nvchad.icons.devicons",
				override_by_extension = {
					astro = {
						icon = "",
						color = "#EF8547",
						name = "astro",
					},
					gleam = {
						icon = "",
						color = "#FFAFF3",
						name = "gleam",
					},
				},
			}
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "devicons")
			require("nvim-web-devicons").setup(opts)
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{
		"tpope/vim-surround",
		event = "BufEnter",
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				multiline = false,
				after = "",
			},
		},
		event = "BufEnter",
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		event = "BufEnter",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar", show_start = false, show_end = false },
		},
	},
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
		lazy = false,
	},
	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
		cmd = "Octo",
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "mbbill/undotree", event = "BufEnter" },
	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require "nvchad"
			vim.opt.showtabline = 0
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},
}
