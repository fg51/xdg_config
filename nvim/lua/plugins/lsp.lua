return {
  {
    "j-hui/fidget.nvim", -- ui for nvim-lsp progress
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "glepnir/lspsaga.nvim", -- ui for lsp
    branch = "main",
    dependencies = { { "nvim-tree/nvim-web-devicons" }, },
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("lspsaga").setup({})
      vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
      vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", { silent = true })

      vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
      vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
      vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
      vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
      vim.keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
      vim.keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

      vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

      vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
      -- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', { silent = true })
      -- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', { silent = true })
      -- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga preview_definition<CR>', { silent = true })
    end,
  },

  {
    "williamboman/mason.nvim", -- lsp manager
    lazy = true,
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "selene",
        "luacheck",
        "eslint_d",
        "shellcheck",
        "deno",
        "shfmt",
        "black",
        -- "isort",
        -- "flake8",
      },
    },
  },

  {
    "b0o/SchemaStore.nvim", -- json schemas for the major config files
  },

  --{
  --  'williamboman/mason-lspconfig.nvim',
  --  lazy = true,
  --  -- config = function()
  --  --   local capabilities = require('cmp_nvim_lsp').default_capabilities()

  --  --   -- require('mason').setup()
  --  --   require('mason-lspconfig').setup()
  --  --   require('mason-lspconfig').setup_handlers({ function(server)
  --  --     require('lspconfig')[server].setup {
  --  --       -- on_attach = on_attach,
  --  --       capabilities = capabilities,
  --  --     }
  --  --   end })
  --  --   vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>')
  --  --   vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  --  --   vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  --  --   vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  --  --   vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  --  --   vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')

  --  --   vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  --  --   vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  --  --   vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  --  --   vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>')

  --  -- end,
  --},

  {
    "neovim/nvim-lspconfig", -- lsp servers
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- closes some gaps that exist between mason.nvim and lspconfig.
      "hrsh7th/cmp-nvim-lsp", -- for complete
      "b0o/SchemaStore.nvim", -- json schemas for the major config files
    },
    lazy = true,
    event = "BufReadPre",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ansiblels = {},
        bashls = {},
        clangd = {},
        cssls = {},
        dockerls = {},
        tsserver = {},
        svelte = {},
        eslint = {},
        html = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        gopls = {},
        marksman = {},
        pyright = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        yamlls = {},
        -- sumneko_lua = {
        --   single_file_support = true,
        --   settings = {
        --     Lua = {
        --       workspace = {
        --         checkThirdParty = false,
        --       },
        --       completion = {
        --         workspaceWord = true,
        --         callSnippet = "Both",
        --       },
        --       misc = {
        --         parameters = {
        --           "--log-level=trace",
        --         },
        --       },
        --       diagnostics = {
        --         -- enable = false,
        --         groupSeverity = {
        --           strong = "Warning",
        --           strict = "Warning",
        --         },
        --         groupFileStatus = {
        --           ["ambiguity"] = "Opened",
        --           ["await"] = "Opened",
        --           ["codestyle"] = "None",
        --           ["duplicate"] = "Opened",
        --           ["global"] = "Opened",
        --           ["luadoc"] = "Opened",
        --           ["redefined"] = "Opened",
        --           ["strict"] = "Opened",
        --           ["strong"] = "Opened",
        --           ["type-check"] = "Opened",
        --           ["unbalanced"] = "Opened",
        --           ["unused"] = "Opened",
        --         },
        --         unusedLocalExclude = { "_*" },
        --       },
        --       format = {
        --         enable = false,
        --         defaultConfig = {
        --           indent_style = "space",
        --           indent_size = "2",
        --           continuation_indent_size = "2",
        --         },
        --       },
        --     },
        --   },
        -- },
        -- teal_ls = {},
        -- vimls = {},
        -- tailwindcss = {},
      },
      ---@type table<string, fun(server:string,  opts:_.lspconfig.options):boolean?>
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
      require("mason-lspconfig").setup_handlers({
        function(server)
          local server_opts = servers[server] or {}
          server_opts.capabilities = capabilities
          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return
            end
          elseif opts.setup["*"] then
            if opts.setup["*"](server, server_opts) then
              return
            end
          end
          require("lspconfig")[server].setup(server_opts)
        end,
      })

      vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>")
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
      vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
      vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")

      vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
      vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>")

      -- Diagnostic symbols in the sign column
      local signs = { Error = " ", Warn = ">>", Hint = ">", Info = ">" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic Settings
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
      })
      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        float = {
          source = "always", -- Or "if_many"
        },
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "BufReadPre",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.rustfmt,
        },
      }
      -- vim.api.nvim_create_autocmd({ 'FileType' }, {
      --   pattern = { 'typescript', 'typescriptreact', 'typescript.tsx' },
      --   callback = function()
      --     vim.keymap.set({ 'n' }, '<Plug>(lsp)f', function()
      --       vim.cmd([[EslintFixAll]])
      --       vim.lsp.buf.format({ name = 'null-ls' })
      --     end)
      --   end,
      -- })
    end,
  },
}
