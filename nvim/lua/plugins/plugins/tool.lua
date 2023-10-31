return {
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = require("plugins.config.trouble"),
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.which-key"),
  },
}
