return {
  ["nvim-treesitter/nvim-treesitter"] = {
    lazy = true,
    event = { "BufReadPre" },
    build = ":TSUpdate",
    dependencies = {
      { "andymass/vim-matchup" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      {
        "windwp/nvim-ts-autotag", -- auto close and rename tags
        config = require("plugins.config.autotag"),
      },
      -- { "mfussenegger/nvim-treehopper" },
      -- { "andymass/vim-matchup" },
      --{
      { "hiphish/rainbow-delimiters.nvim", config = require("plugins.config.rainbow_delimiters") },
      --{ "hiphish/rainbow-delimiters.nvim" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("plugins.config.ts-context"),
      },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    --config = require("editor.treesitter"),
    config = vim.schedule_wrap(function()
      --local use_ssh = require("core.settings").use_ssh

      vim.api.nvim_set_option_value("foldmethod", "expr", {})
      vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

      require("nvim-treesitter").setup({
        -- auto_install = false,
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(ft, bufnr)
            if vim.tbl_contains({ "vim" }, ft) then
              return true
            end

            local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
            return ok and is_large_file
          end,
          additional_vim_regex_highlighting = { "c", "cpp" },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]["] = "@function.outer",
              ["]m"] = "@class.outer",
            },
            goto_next_end = {
              ["]]"] = "@function.outer",
              ["]M"] = "@class.outer",
            },
            goto_previous_start = {
              ["[["] = "@function.outer",
              ["[m"] = "@class.outer",
            },
            goto_previous_end = {
              ["[]"] = "@function.outer",
              ["[M"] = "@class.outer",
            },
          },
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        matchup = { enable = true },
        ignore_install = { "help" },
        ensure_installed = {
          "astro",
          "bash",
          "c",
          "cmake",
          -- "comment", -- comments are slowing down TS bigtime, so disable for now
          "cpp",
          "css",
          "diff",
          "fish",
          "gitignore",
          "go",
          "graphql",
          "help",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "ninja",
          "php",
          "python",
          "regex",
          "rust",
          "scss",
          "sql",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vue",
          "yaml",
          "zig",
        },
      })
      --  require("nvim-treesitter.install").prefer_git = true
      --  if use_ssh then
      --    local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      --    for _, p in pairs(parsers) do
      --      p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
      --    end
      --  end
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end),

    --    ---@type TSConfig
    --    opts = {
    --      indent = {
    --        enable = false,
    --        disable = {},
    --      },
    --      autotag = {
    --        enable = true,
    --        filetypes = {
    --          "astro",
    --          "html",
    --          "javascript",
    --          "javascriptreact",
    --          "jsx",
    --          "markdown",
    --          "svelte",
    --          "tsx",
    --          "typescript",
    --          "typescriptreact",
    --          "vue",
    --        },
    --      },
    --      context_commentstring = { enable = true, enable_automd = false },
    --      ignore_install = { "help" },
    --      ensure_installed = {
    --        "astro",
    --        "bash",
    --        "c",
    --        "cmake",
    --        -- "comment", -- comments are slowing down TS bigtime, so disable for now
    --        "cpp",
    --        "diff",
    --        "fish",
    --        "gitignore",
    --        "go",
    --        "graphql",
    --        "help",
    --        "http",
    --        "javascript",
    --        "jsdoc",
    --        "json",
    --        "jsonc",
    --        "latex",
    --        "lua",
    --        "markdown",
    --        "markdown_inline",
    --        "ninja",
    --        "php",
    --        "python",
    --        "regex",
    --        "rust",
    --        "scss",
    --        "sql",
    --        "svelte",
    --        "toml",
    --        "tsx",
    --        "typescript",
    --        "vim",
    --        "vue",
    --        "yaml",
    --        "zig",
    --      },
    --    },
    --    ---@param opts TSConfig
    --    config = function(_, opts)
    --      require("nvim-treesitter.configs").setup(opts)
    --      -- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    --      -- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    --    end,
    --  },
  },
}
