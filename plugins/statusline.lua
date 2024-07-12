return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- add new user interface icon
      icons = {
        VimIcon = "",
        ScrollText = "",
        FileLine = "󰈙",
        FolderEmptyIcon = " ",
        GitBranch = "",
        -- GitBranch = "",
        GitAdd = "",
        GitChange = "",
        GitDelete = "",
        UnixIcon = '', -- e712
        DosIcon = '',  -- e70f
        MacIcon = '',  -- e711
      },
      -- modify variables used by heirline but not defined in the setup call directly
      status = {
        -- define the separators between each section
        separators = {
          left = { "", "" },
          left_with_space = { "", " " },
          -- left = { "", "" },
          right = { "", "" },
          -- right = { "", "" },
          -- left_thin = { "", "" },
          right_thin = { " ", "" },
        },
        -- add new colors that can be used by heirline
        colors = function(hl)
          local get_hlgroup = require("astroui").get_hlgroup
          -- use helper function to get highlight group properties
          local comment_fg = get_hlgroup("Comment").fg
          hl.git_branch_fg = comment_fg
          hl.git_added = comment_fg
          hl.git_changed = comment_fg
          hl.git_removed = comment_fg
          hl.blank_bg = get_hlgroup("Folded").fg
          hl.file_info_bg = get_hlgroup("Visual").bg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          hl.folder_icon_bg = get_hlgroup("Error").fg
          -- hl.encoded_bg = get_hlgroup("Conditional").fg -- violet 
          hl.encoded_bg = get_hlgroup("DiagnosticInfo").fg -- blue 
          -- hl.encoded_bg= get_hlgroup("DiagnosticWarn").fg -- orange
          return hl
        end,
        attributes = {
          mode = { bold = true },
        },
        icon_highlights = {
          file_icon = {
            statusline = false,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      local path_func = status.provider.filename { modify = ":.:h", fallback = "" }

      -- disable winbar
      opts.winbar = nil

      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },

        status.component.mode {
          mode_text = {
            icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
          },
          surround = {
            separator = "left",
            color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
          },
        },
        status.component.builder {
          { provider = "" },
          surround = {
            separator = "left_with_space",
            color = { main = "blank_bg", right = "bg" },
          },
        },
        status.component.separated_path {
          path_func = path_func,
          hl = { fg = "blank_bg", bg = "bg" },
        },
        status.component.file_info {
          file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
          filename = {},
          filetype = false,
          file_modified = false,
          file_read_only = false,
          -- hl = status.hl.get_attributes("winbar", true),
          hl = { fg = "blank_bg", bg = "bg" },
          surround = false,
          update = "BufEnter",
        },
        -- status.component.file_info {
        --   filename = { fallback = "Empty" },
        --   filetype = false,
        --   file_read_only = false,
        --   padding = { right = 1 },
        --   surround = { separator = "left", condition = false },
        -- },
        -- status.component.breadcrumbs {
        --   hl = { fg = "blank_bg", bg = "bg" },
        --   -- hl = status.hl.get_attributes("winbarnc", true),
        --   -- prefix = true,
        --   padding = { left = 1 },
        -- },
        status.component.fill(),
        -- status.component.lsp {
        --   lsp_client_names = false,
        --   surround = { separator = "none", color = "bg" },
        -- },
        status.component.fill(),
        -- add a component for the current diagnostics if it exists and use the right separator for the section
        status.component.diagnostics { surround = { separator = "right" }, padding = { right = 1 } },
        status.component.git_branch {
          git_branch = { padding = { left = 1, right = 1 } },
          surround = { separator = "none" },
        },
        status.component.git_diff {
          padding = { right = 1 },
          surround = { separator = "none" },
        },
        -- lsp info
        -- status.component.lsp {
        --   lsp_progress = false,
        --   padding = { right = 1 },
        --   surround = { separator = "right" },
        -- },
        -- folder info
        {
          flexible = 1,
          {
            status.component.builder {
              { provider = require("astroui").get_icon "FolderClosed" },
              padding = { right = 1 },
              hl = { fg = "bg" },
              surround = { separator = "right", color = "folder_icon_bg" },
            },
            -- status.component.separated_path { path_func = path_func },
            status.component.file_info {
              filename = {
                fname = function(nr) return vim.fn.getcwd(nr) end,
                padding = { left = 1, right = 1 },
              },
              filetype = false,
              file_icon = false,
              file_modified = false,
              file_read_only = false,
              surround = {
                separator = "none",
                color = "file_info_bg",
                condition = false,
              },
            },
          },
        },
        {
          status.component.builder {
            { provider = require("astroui").get_icon "UnixIcon" },
            padding = { right = 1 },
            hl = { fg = "bg" },
            surround = {
              separator = "right",
              color = { main = "encoded_bg", left = "file_info_bg" },
            },
          },
          status.component.builder {
            { provider = require("astroui.status").provider.file_encoding() },
            padding = { left = 1, right = 1 },
            file_icon = false,
            file_modified = false,
            file_read_only = false,
            surround = {
              separator = "none",
              color = { main = "file_info_bg", left = "folder_icon_bg" },
              condition = false,
            },
          },
          status.component.builder {
            { provider = require("astroui").get_icon "ScrollText" },
            padding = { right = 1 },
            hl = { fg = "bg" },
            surround = {
              separator = "right",
              color = { main = "nav_icon_bg", left = "file_info_bg" },
            },
          },
          status.component.nav {
            padding = { left = 1 },
            percentage = false,
            scrollbar = false,
            surround = { separator = "none", color = "file_info_bg" },
          },
          status.component.builder {
            surround = {
              separator = "right_thin",
              color = { main = "nav_icon_bg", left = "file_info_bg" },
            },
          },
          status.component.nav {
            percentage = { padding = { right = 1 } },
            ruler = false,
            scrollbar = false,
            surround = { separator = "none", color = "file_info_bg" },
          },
        },
      }
    end,
  },
}
