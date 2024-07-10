-- local prefix =  "<leader>j"
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        showtabline = 0,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    mappings = {
      -- first key is the mode
      n = {
        -- Save all
        ["<leader>w"] = { ":wa<cr>", desc = "Save all" },
        -- Select all
        ["<C-a>"] = { "<esc>ggVG", desc = "Select All" },
        -- Edit buffer
        ["<leader>be"] = { ":e<cr>", desc = "Edit buffer" },
         -- Jester
        -- [prefix] = { desc = "Jester" },
        -- [prefix .. "r"] = { ":lua require'jester'.run()<cr>", desc = "Run current test (Jest)" },
        -- [prefix .. "f"] = { ":lua require'jester'.run_file()<cr>", desc = "Run file (Jest)" },
        -- [prefix .. "d"] = { ":lua require'jester'.debug_file()<cr>", desc = "Debug file (Jest)" },

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      v = {
        -- Save all
        ["<leader>w"] = { ":wa<cr>", desc = "Save all" },
        -- Select all
        ["<C-a>"] = { "<esc>ggVG", desc = "Select All" },
        -- Edit buffer
        ["<leader>be"] = { ":e<cr>", desc = "Edit buffer" },
      },
      i = {
        ["<C-a>"] = { "<esc>ggVG", desc = "Select All" },
      },
    },
  },
}
