-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}
M.base46 = {
	theme = "tokyonight",
	transparency = true,
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
		["@keyword.function"] = { bold = true },
		["@keyword.return"] = { bold = true },
		["@keyword.conditional"] = { bold = true },
		["@keyword"] = { italic = true },
		["@markup.heading"] = { bold = true },
	},
}

M.ui = {
	cmp = {
		format_colors = {
			tailwind = true,
		},
	},
	telescope = {
		style = "bordered",
	},
}

return M
