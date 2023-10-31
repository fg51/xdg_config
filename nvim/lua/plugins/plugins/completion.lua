return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("plugins.config.lsp"),
    dependencies = {
      { "b0o/SchemaStore.nvim" }, -- json schemas for the major config files
      {
        "Jint-lzxy/lsp_signature.nvim",
        opt = require("plugins.config.lsp-signature"),
      },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("plugins.config.lspsaga"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  --completion["simrat39/symbols-outline.nvim"] = {
  --	lazy = true,
  --	event = "LspAttach",
  --	config = require("completion.symbols-outline"),
  --}
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    config = require("plugins.config.cmp"),
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = require("plugins.config.luasnip"),
      },
      --{ "lukas-reineke/cmp-under-comparator" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      --{ "f3fora/cmp-spell" },
      { "hrsh7th/cmp-buffer" },
      --{ "kdheepak/cmp-latex-symbols" },
      {
        "windwp/nvim-autopairs", -- autopair
        opts = {},
      },
      { "ray-x/cmp-treesitter", commit = "c8e3a74" },
    },
  },
  {
    "williamboman/mason.nvim", -- lsp manager
    lazy = true,
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "bashls",
        "black",
        "clangd",
        "deno",
        "eslint_d",
        "html",
        "lua_ls",
        "luacheck",
        "prettierd",
        -- "pylsp",
        "selene",
        "shellcheck",
        "shfmt",
        "stylua",
        -- "isort",
        -- "flake8",
      },
    },
  },
}
