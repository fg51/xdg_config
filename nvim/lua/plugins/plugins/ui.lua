return {
  {
    "nvim-lualine/lualine.nvim", -- statusline
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- file icons
    opts = require("plugins.config.lualine"),
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    lazy = true,
    event = { "InsertEnter" },
    opts = {},
    -- symbol = "| ",
  },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = require("plugins.config.notify"),
      },
    },
    opts = require("plugins.config.noice"),
  },
  {
    "j-hui/fidget.nvim", -- ui for nvim-lsp progress
    lazy = true,
    -- tag = "legacy",
    event = "LspAttach",
    config = require("plugins.config.fidget"),
  },
}
