return {
  ["nvim-treesitter/nvim-treesitter"] = {
    lazy = true,
    build = ":TSUpdate",
    --build = function()
    --  if #vim.api.nvim_list_uis() > 0 then
    --    vim.api.nvim_command([[TSUpdate]])
    --  end
    --end,
    event = "BufReadPre",
    -- config = require("editor.treesitter"),
    dependencies = {
    --  { "andymass/vim-matchup" },
    --   { "mfussenegger/nvim-treehopper" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      {
        "windwp/nvim-ts-autotag",
         config = require("plugins.config.autotag"),
      },
      {
        "hiphish/rainbow-delimiters.nvim",
        config = require("plugins.config.rainbow_delimiters"),
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("plugins.config.ts-context"),
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = require("plugins.config.ts-context-commentstring"),
      },
    },
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
            if vim.tbl_contains({ "gitcommit" }, ft)
              or (vim.api.nvim_buf_line_count(bufnr) > 7500
              and ft ~= "vimdoc")
            then
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
				    -- lookahead = true,
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
        indent = { enable = true },
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
