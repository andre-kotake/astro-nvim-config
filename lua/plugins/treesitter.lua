-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      disable = function()
        -- check if 'filetype' option includes 'chezmoitmpl'
        if string.find(vim.bo.filetype, "chezmoitmpl") then return true end
      end,
    },

    ensure_installed = {
      "lua",
      "luadoc",
      "luap",
      "vim",
      "vimdoc",
      "bash",
      "diff",
      "git_config",
      "gitcommit",
      "gitignore",
      "jsdoc",
      "jsonc",
      "json5",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "toml",
      "xml",
      "yaml",
    },
  },
}
