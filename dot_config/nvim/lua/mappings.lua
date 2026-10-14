require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- shortcuts
map("i", "jk", "<ESC>", { nowait = true })
map("n", "<leader>Q", ":q<CR>", { desc = "command close" })
map("n", "<leader>hc", ":nohl<CR>", { desc = "clear highlights" })
map("n", "<leader>O", ":normal o<CR>", { desc = "insert line" })

-- tabs
map("n", "<leader>tn", ":tabnew<CR>")

-- ui
map("n", "<leader><leader>t", function()
	require("base46").toggle_transparency()
end)

-- Do not keep pasted lines
map("x", "p", '"_dP')
map("x", "P", '"_dP')

-- Improvements to document navigation
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })
map("n", "G", "Gzz", { desc = "go to bottom and center" })
map("n", "<C-f>", "10jzz", { desc = "gentle scroll down" })
map("n", "<C-y>", "10fzz", { desc = "gentle scroll up" })

-- Tmux Navigate mappings
-- map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
-- map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
-- map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
-- map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

map("i", "<A-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<A-e>", "<End>", { desc = "move end of line" })
map("i", "<A-h>", "<Left>", { desc = "move left" })
map("i", "<A-l>", "<Right>", { desc = "move right" })
map("i", "<A-j>", "<Down>", { desc = "move down" })
map("i", "<A-k>", "<Up>", { desc = "move up" })

map("n", "<A-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<A-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<A-k>", "<C-w>k", { desc = "switch window up" })

-- Telescope
map("n", "<leader>fW", require("telescope.builtin").resume, {
	noremap = true,
	silent = true,
	desc = "Search Resume",
})

--LSP mappings
map("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>")
map("n", "ca", "<cmd>Lspsaga code_action<CR>")
map("n", "gf", "<cmd>Lspsaga finder<CR>")
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

map("n", "<leader>xa", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
map("n", "<leader>xb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
map("n", "<leader>xc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

map("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

map("n", "<leader>rr", "<cmd>Lspsaga rename<CR>")
map("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Bufferline commands
local function close_buffer()
	require("nvchad.tabufline").close_buffer()
end
map("n", "<leader>q", close_buffer, { desc = "close the current buffer" })
local function close_all_buffers()
	require("nvchad.tabufline").closeAllBufs()
end
map("n", "<leader><leader>q", close_all_buffers)

--term
map({ "n", "t" }, "<leader>I", function()
	require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal", nowait = true })
map("n", "<leader>H", function()
	require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "<leader>th", function()
	require("nvchad.themes").open()
end)

-- Move highlighted lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Paste below
map("v", "yp", "y']p", { desc = "copy and paste below" })

-- Todo plugin mappings
map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
map("n", "<leader>ft", "<cmd> TodoTelescope<CR>")
map("n", "<leader>tt", "<cmd> Trouble todo<CR>", { noremap = true, silent = true })

map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")
map("n", "]c", "<cmd>Gitsigns next_hunk<CR>")
map("n", "[c", "<cmd>Gitsigns prev_hunk<CR>")

-- arrow mappings
map("n", "H", require("arrow.persist").previous)
map("n", "L", require("arrow.persist").next)
map("n", "<C-s>", require("arrow.persist").toggle)

-- Octo github shortcuts
map("n", "<leader><leader>gi", "<cmd>Octo issue create<CR>")

-- Remove plugin keymaps etc..
del("n", "<leader>x")
del("n", "<leader>h")

-- Plugin development
map("n", "<leader>R", function()
	-- Clear the module cache for your plugin
	for name, _ in pairs(package.loaded) do
		if name:match "^double-slash" then
			package.loaded[name] = nil
		end
	end

	-- Re-source the plugin
	require("double-slash").setup()

	print "Reloaded double-slash"
end, { desc = "Reload double-slash" })
