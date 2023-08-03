return {
  --{
  --  "lambdalisue/fern.vim",
  --  lazy = true,
  --  cmd = { "Fern" },
  --},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
  },
}
