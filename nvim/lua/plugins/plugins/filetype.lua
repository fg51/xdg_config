return {
--   ["sirtaj/vim-openscad"] = { ft = "scad" }, -- filetype
--   ["ron-rs/ron.vim"] = { ft = "ron" }, -- filetype
   ["mattn/emmet-vim"] = { ft = { "css", "html", "javascript", "markdown", "typescript", "svelte" } }, -- filetype
--   ["iamcco/markdown-preview.nvim"] = {
--     lazy = true,
--     ft = { "md", "markdown" },
--     build = function()
--       vim.fn["mkdp#util#install"]()
--     end,
--     config = function()
--       vim.g.mkdp_echo_preview_url = 1
--     end,
--   },

--   ["fatih/vim-go"] = {
--     lazy = true,
--     ft = "go",
--     build = ":GoInstallBinaries",
--     -- config = require("lang.vim-go"),
--   },
  ["mrcjkb/rustaceanvim"] = {
--     version = "^4",
    version = "*",
    lazy = true,
    ft = "rust",
--     -- dependencies = { "nvim-lua/plenary.nvim" },
    init = require("plugins.config.rustaceanvim"),
  },
  -- dependencies for rustaceanvim
  ["nvim-lua/plenary.nvim"] = {
    lazy = true,
    event = "VeryLazy",
  },

  ["Saecki/crates.nvim"] = {
    lazy = true,
    event = "BufReadPost Cargo.toml",
--     dependencies = { "nvim-lua/plenary.nvim" },
    config = require("plugins.config.crates"),
  },
  -- dependencies for crates.nvim
  ["nvim-lua/plenary.nvim"] = {
    lazy = true,
    event = "VeryLazy",
  },
--   ["chrisbra/csv.vim"] = {
--     lazy = true,
--     ft = "csv",
--   },
--   ["evanleck/vim-svelte"] = {
--     ft = "svelte",
--   },
--   ["MeanderingProgrammer/render-markdown.nvim"] = {
--     lazy = true,
--     ft = "markdown",
--     config = require("plugins.config.lang.render-markdown"),
--     dependencies = {
--       "nvim-tree/nvim-web-devicons",
--       "nvim-treesitter/nvim-treesitter",
--     },
--   },
}
