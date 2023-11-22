return {
  { "sirtaj/vim-openscad", ft = "scad" }, -- filetype
  { "ron-rs/ron.vim", ft = "ron" }, -- filetype
  { "mattn/emmet-vim", ft = { "css", "html", "javascript", "markdown", "typescript", "svelte" } }, -- filetype
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "md", "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
  {
    "fatih/vim-go",
    lazy = true,
    ft = "go",
    build = ":GoInstallBinaries",
    -- config = require("lang.vim-go"),
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = "rust",
    dependencies = { "nvim-lua/plenary.nvim" },
    opt = require("plugins.config.rust-tools"),
  },
  {
    "Saecki/crates.nvim",
    lazy = true,
    event = "BufReadPost Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    --	config = require("lang.crates"),
  },
  {
    "chrisbra/csv.vim",
    lazy = true,
    ft = "csv",
  },
  {
    "evanleck/vim-svelte",
    ft = "svelte",
  },
}
