return {
  {
    'nvim-lualine/lualine.nvim', -- statusline
    lazy = true,
    -- event = "BufEnter",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" }, -- file icons
  },
}
