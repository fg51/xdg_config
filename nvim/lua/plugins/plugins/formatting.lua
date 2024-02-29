vim.g.nonels_suppress_issue58 = false

return {
  ["joechrisellis/lsp-format-modifications.nvim"] = {
    lazy = true,
    event = "LspAttach",
  },
  -- "jose-elias-alvarez/null-ls.nvim",
  ["nvimtools/none-ls.nvim"] = {
    lazy = true,
    commit = "b4bd764cd1705086de4bd89f7ccf9d9ed0401259",
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.null-ls"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
  },
}
