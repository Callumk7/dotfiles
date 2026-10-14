return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    filters = {
      dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      signcolumn = "no",
      side = "right",
      float = {
        enable = true,
        open_win_config = function()
          local HEIGHT_RATIO = 0.8
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_h = screen_h * HEIGHT_RATIO
          local window_h_int = math.floor(window_h)
          return {
            border = "rounded",
            relative = "editor",
            row = 0,
            col = 0,
            width = 60,
            height = window_h_int,
          }
        end,
      },
      width = 60,
    },
    git = {
      enable = true,
      ignore = false,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = false,
      highlight_git = "name",
      highlight_opened_files = "icon",

      indent_markers = {
        enable = true,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        git_placement = "after",
        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },
}
