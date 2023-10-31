return {
  {
    "kylechui/nvim-surround", -- add/delete/change surrounding pairs
    lazy = true,
    version = "*",
    event = { "VeryLazy" }, -- event = { 'VimEnter' },
    opts = {},
    --config = function()
    --  require("nvim-surround").setup({})
    --end,
  },
  {
    "junegunn/vim-easy-align",
    lazy = true,
    cmd = "EasyAlign",
  },
  {
    "smoka7/hop.nvim",
    lazy = true,
    version = "*",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
}
