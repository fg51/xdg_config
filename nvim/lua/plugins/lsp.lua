return {
  {
    'j-hui/fidget.nvim', -- ui for nvim-lsp progress
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require "fidget".setup {}
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    -- event = 'BufEnter',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'tami5/lspsaga.nvim',
    },
    config = function()
      local on_attach = function(client, bufnr)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
        -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        -- vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        vim.keymap.set('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', { silent = true })
        vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
        vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
        -- vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

        vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        -- vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
        -- vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        vim.keymap.set({ 'n', 'v' }, '<space>ca', "<cmd>Lspsaga code_action<CR>", { silent = true })
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        -- vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
        vim.keymap.set('n', "<space>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
        -- vim.keymap.set('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>')
        --vim.keymap.set('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        vim.keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
        vim.keymap.set('n', "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
        vim.keymap.set('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
        vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>')
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })


        vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
        -- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', { silent = true })
        -- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', { silent = true })
        -- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga preview_definition<CR>', { silent = true })
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({ function(server)
        require('lspconfig')[server].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end })

      -- Diagnostic symbols in the sign column
      local signs = { Error = " ", Warn = ">>", Hint = ">", Info = ">" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      -- Diagnostic Settings
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
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
  --  use {
  --    'jayp0521/mason-null-ls.nvim',
  --    opt = true,
  --    requires = {
  --      { 'williamboman/mason.nvim', opt = true, } ,
  --      { 'jose-elias-alvarez/null-ls.nvim', opt = true, },
  --    },
  --    wants = { 'mason.nvim', 'null-ls' },
  --    config = function()
  --      require'mason-null-ls'.setup()
  --      local null_ls = require'null-ls'
  --      null_ls.setup({
  --        sources = { null_ls.builtins.formatting.prettier },
  --      })
  --
  --      -- vim.api.nvim_create_autocmd({ 'FileType' }, {
  --      --   pattern = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  --      --   callback = function()
  --      --     vim.keymap.set({ 'n' }, '<Plug>(lsp)f', function()
  --      --       vim.cmd([[EslintFixAll]])
  --      --       vim.lsp.buf.format({ name = 'null-ls' })
  --      --     end)
  --      --   end,
  --      -- })
  --    end
  --  }


}
