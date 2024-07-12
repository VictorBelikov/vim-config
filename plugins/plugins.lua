return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require("astronvim.plugins.configs.luasnip")(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "haydenmeade/neotest-jest",
    },
  },
  {},
  -- {
  -- https://github.com/David-Kunz/jester
  --   "David-Kunz/jester",
  --   config = function()
  --     require("jester").setup {
  --       terminal_cmd = "terminal",
  --     }
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        -- flavour = "Macchiato",
        flavour = "Mocha",
        styles = {}
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        -- style = "storm",
        style = "moon",
        -- style = "night",
        -- transparent = true
        styles = {
          -- keywords = { bold = true },
          -- functions = { bold = true },
        },
      }
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'hard'
    end
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      -- vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_background = 'medium'
      -- vim.g.gruvbox_material_background = 'soft'
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup {
        options = {
          styles = {
            comments = "italic",
            -- keywords = "bold",
            types = "bold",
          }
        }
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = { ui = { bg_gutter = "none" } } },
        },
        background = {
          dark = "wave",
          -- dark = "dragon",
          light = "lotus"
        },
      }
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = 'darker', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,  -- Show/hide background
      }
    end,
  }
}