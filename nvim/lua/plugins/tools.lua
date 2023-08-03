return {
  {
    "editorconfig/editorconfig-vim",
    lazy = false,
  },
  {
    "kylechui/nvim-surround", -- add/delete/change surrounding pairs
    version = "*",
    event = { "VeryLazy" }, -- event = { 'VimEnter' },
    config = function()
      require 'nvim-surround'.setup({})
    end
  },

  --  { 'h1mesuke/vim-alignta', opt = true, cmd = 'Alignta' }

  {
    "windwp/nvim-autopairs", -- autopair
    lazy = true,
    event = { "InsertEnter" },
    -- config = function()
    --   require 'nvim-autopairs'.setup()
    -- end,
  },
  {
    "windwp/nvim-ts-autotag", -- autotag for html
    event = { "InsertEnter" },
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },
  {
    "phaazon/hop.nvim",
    version = "v2",
    lazy = true,
    -- event = "VeryLazy",
    keys = {
      { "f", "<cmd>lua require'hop'.hint_char1()<cr>" },
      { "<leader>hf", "<cmd>lua require'hop'.hint_char2()<cr>" },
    },
    config = function()
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
      })
      -- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
      -- vim.api.nvim_set_keymap('n', '<leader>hf', "<cmd>lua require'hop'.hint_char2()<cr>",
      --   { noremap = true, silent = false })
    end,
  },
  {
    "stevearc/dressing.nvim", -- allow plugin authors to override them with improvements upon ghe default behavior
    lazy = true,
    event = "VeryLazy",
  },
}
