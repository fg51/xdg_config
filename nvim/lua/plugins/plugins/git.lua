return {
  ["lambdalisue/gina.vim"] = {
    lazy = true,
    cmd = { "Gina" },
  },
  ["lewis6991/gitsigns.nvim"] = { -- show a git diff in the sign column
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("gitsigns").setup()
    end,
  },
}
