-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "gbprod/none-ls-shellcheck.nvim",
  },
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require("null-ls")
    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local hover = null_ls.builtins.hover

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)

    local sources = {
      code_actions.refactoring,

      -- lua
      diagnostics.selene,
      formatting.stylua,

      -- sh
      hover.printenv,
      diagnostics.dotenv_linter,
      formatting.shfmt.with({ extra_args = { "-i", "2", "-ci", "-bn" } }),
      require("none-ls-shellcheck.code_actions"),
      formatting.shellharden,

      -- json
      formatting.prettierd,

      -- yaml
      diagnostics.yamllint,
      formatting.yamlfix.with({
        extra_args = {
          "--config-file",
          vim.fn.expand("~/.config/yamlfix/config.toml"),
        },
      }),
    }

    opts.sources = sources
    -- opts.sources = require("astrocore").list_insert_unique(opts.sources, sources)
  end,
}
