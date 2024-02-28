return {
  {
    -- "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.null-ls"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    lazy = true,
    event = "LspAttach",
  },
}
