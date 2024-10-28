-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec[]
return {
  {
    dir = vim.fn.expand("~/Repos/nvim-chezmoi"),
    lazy = false,
    enabled = true,
    opts = {
      debug = true,
      source_path = vim.fn.expand("~/Repos/dotfiles/home"),
    },
  },
  -- {
  --   "antonk52/bad-practices.nvim",
  --   lazy = false,
  --   opts = {
  --     most_splits = 3, -- how many splits are considered a good practice(default: 3)
  --     most_tabs = 3, -- how many tabs are considered a good practice(default: 3)
  --     max_hjkl = 10, -- how many times you can spam hjkl keys in a row(default: 10)
  --   },
  --   setup = function(_, opts) require("bad-practices").config(opts) end,
  -- },
  {
    "Exafunction/codeium.nvim",
    event = "User AstroFile",
    -- enabled = false,
    cmd = "Codeium",
    opts = {
      enable_chat = false,
    },
    dependencies = {
      {
        "AstroNvim/astroui",
        ---@type AstroUIOpts
        opts = {
          icons = {
            Codeium = "",
          },
        },
      },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            mappings = {
              n = {
                ["<Leader>;"] = {
                  desc = require("astroui").get_icon("Codeium", 1, true) .. "Codeium",
                },
                ["<Leader>;o"] = {
                  desc = "Open Chat",
                  function() vim.cmd("Codeium Chat") end,
                },
              },
            },
          })
        end,
      },
    },
    specs = {
      {
        "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
          -- Inject codeium into cmp sources, with high priority
          table.insert(opts.sources, 1, {
            name = "codeium",
            group_index = 1,
            priority = 10000,
          })

          return opts
        end,
      },
      {
        "onsails/lspkind.nvim",
        optional = true,
        -- Adds icon for codeium using lspkind
        opts = function(_, opts)
          if not opts.symbol_map then opts.symbol_map = {} end
          opts.symbol_map.Codeium = require("astroui").get_icon("Codeium", 1, true)
        end,
      },
    },
  },
}
