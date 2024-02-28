return {
  ["EdenEast/nightfox.nvim"] = { -- theme
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
        on_attach = vim.cmd("colorscheme duskfox"),
      })
      -- vim.cmd([[colorscheme nightfox]])
    end,
  }
}
