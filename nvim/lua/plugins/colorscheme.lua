return {
  {
    "EdenEast/nightfox.nvim", -- theme
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme nightfox]]
    end,
  },
}
