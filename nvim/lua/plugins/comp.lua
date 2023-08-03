return {
  {
    "hrsh7th/nvim-cmp", -- complete
    lazy = true,
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
      -- {
      --   "ray-x/lsp_signature.nvim",  -- show function signature for complete
      --   opts = {
      --     hint_enable = false,
      --   },
      -- },
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        enable = true,
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        --experimental = {
        --  ghost_text = false,
        --},
        formatting = {
          -- fields = { "abbr", "kind", "menu" }
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      --cmp.setup.cmdline("/", {
      --  mapping = cmp.mapping.preset.cmdline(),
      --  sources = {
      --    { name = "buffer" },
      --  },
      --})
      --cmp.setup.cmdline(":", {
      --  mapping = cmp.mapping.preset.cmdline(),
      --  sources = cmp.config.sources({
      --    { name = "path" },
      --  }, {
      --    { name = 'cmdline' }
      --  })
      --})

      local lspkind = require("lspkind")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
      })

      require("nvim-autopairs").setup()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "hrsh7th/vim-vsnip-integ", -- complete engine for vim-vsnip
    lazy = true,
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/vim-vsnip", -- snippet like vscode
      "rafamadriz/friendly-snippets", -- snippet dictionary
    },
    config = function()
      -- Expand
      vim.cmd([[ imap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]])
      vim.cmd([[ smap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]])

      -- Expand or jump
      -- imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      -- smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      -- Jump forward or backward
      vim.cmd([[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]])
      vim.cmd([[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]])
      vim.cmd([[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]])
      vim.cmd([[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]])
    end,
  },
}
