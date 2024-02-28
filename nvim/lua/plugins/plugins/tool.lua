return {
  ["folke/trouble.nvim"] = {
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = require("plugins.config.trouble"),
  },
  ["folke/which-key.nvim"] = {
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.which-key"),
  },
  ["mfussenegger/nvim-dap"] = {
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = require("plugins.config.dap"),
    --config = require("tool.dap"),
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = require("plugins.config.dap.dapui"),
        --config = require("tool.dap.dapui"),
      },
      { "jay-babu/mason-nvim-dap.nvim" },
    },
  },
}
