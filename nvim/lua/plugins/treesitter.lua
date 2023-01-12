return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufReadPost",
    -- event = "BufEnter",
    build = ":TSUpdate",
    ---@type TSConfig
    opts = {
      -- auto_install = false,
      sync_install = false,
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      autotag = {
        enable = true,
      },
      context_commentstring = { enable = true, enable_automd = false },
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "cpp",
        "diff",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "help",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "ninja",
        "php",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      -- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
  },
}
