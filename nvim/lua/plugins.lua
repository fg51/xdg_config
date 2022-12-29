local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

-- requires: loading the required plugins before loading the plugin
-- setup: run code before loading the plugin
-- config: run code after loading the plugin

return packer.startup(function()
  -- packer can mange itself
  use 'wbthomason/packer.nvim'


  --use {
  --  'neoclide/coc.nvim',
  --  branch = 'release',
  -- config = vim.cmd
  --  set updatetime=300
  --  if has("patch-8.1.1564")
  --    set signcolumn=number
  --  else
  --    set signcolumn=yes
  --  endif
  --
  --  " Use [g and ]g to navigate diagnostics
  --  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  --  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  --
  --  " goto code navigation.
  --  nmap <silent> gd <Plug>(coc-definition)
  --  nmap <silent> gy <Plug>(coc-type-definition)
  --  nmap <silent> gi <Plug>(coc-implementation)
  --  nmap <silent> gr <Plug>(coc-references)
  --'''

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use { 'sirtaj/vim-openscad', ft = 'scad' } -- filetype
  use { 'ron-rs/ron.vim', ft = 'ron' } -- filetype

  use 'EdenEast/nightfox.nvim'  -- theme
  --use { 'EdenEast/nightfox.nvim',
  --  config = function()
  --    require('nightfox').setup({
  --      options = {
  --        transparent = true
  --      },
  --      on_attach = vim.cmd("colorscheme duskfox"),
  --    })
  --  end,
  --  --setup = function()
  --  --  vim.cmd("colorscheme duskfox")
  --  --end
  --}

  use 'editorconfig/editorconfig-vim'

  -- use 'vim-scripts/gtags.vim'

  -- use 'tpope/vim-surround'
  use 'machakann/vim-sandwich'

  use { 'h1mesuke/vim-alignta', opt = true, cmd = 'Alignta' }


  --  --# GIT {{{
  --  --[[plugins]]
  --  --repo = 'tpope/vim-fugitive'
  --  --on_cmd=['Git', 'Gwrite', 'Gread', 'Gcommit', 'Gdiff', 'Gvdiff']
  --  use {
  --    'tpope/vim-fugitive',
  --    opt = true,
  --    cmd = {'Git', 'Gwrite', 'Gread', 'Gcommit', 'Ggrep'},
  --  }
  use {
    'lambdalisue/gina.vim',
    opt = true,
    cmd = { 'Gina' },
  }

  use {
    'airblade/vim-gitgutter',
    opt = true,
    event = 'VimEnter',
  }
  --  --# }}} GIT


  use { 'mattn/emmet-vim', ft = { 'css', 'html', 'javascript', 'markdown', 'typescript', } }

  use {
    'nvim-lualine/lualine.nvim', -- statusline
    requires = {
      'kyazdani42/nvim-web-devicons',  -- file icons
      opt = true
    },
  }


  use {
    'nvim-telescope/telescope.nvim', -- finder
    opt = true,
    cmd = 'Telescope',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- lsp {{{
  use 'williamboman/mason.nvim'

  -- use { "neovim/nvim-lspconfig", }

  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    -- opt = true,
    --event = 'BufEnter',
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
        vim.keymap.set({'n', 'v'}, '<space>ca', "<cmd>Lspsaga code_action<CR>", { silent = true })
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
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require"fidget".setup{}
    end
  }

  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      local saga = require"lspsaga"
      saga.init_lsp_saga({
        -- Options with default value
        -- "single" | "double" | "rounded" | "bold" | "plus"
        border_style = "single",
        --the range of 0 for fully opaque window (disabled) to 100 for fully
        --transparent background. Values between 0-30 are typically most useful.
        saga_winblend = 5,
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = '<C-p>',next = '<C-n>'},
        diagnostic_header = { " ", " ", " ", "ﴞ " },
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 10,
        -- use emoji lightbulb in default
        code_action_icon = "◆",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = false,
            enable_in_insert = false,
            cache_code_action = false,
            sign = true,
            update_time = 150,
            sign_priority = 20,
            virtual_text = true,
        },
        -- finder icons
        finder_icons = {
          def = '  ',
          ref = '諭 ',
          link = '  ',
        },
        -- finder do lsp request timeout
        -- if your project big enough or your server very slow
        -- you may need to increase this value
        finder_request_timeout = 1500,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "q",
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        definition_action_keys = {
          edit = '<C-c>o',
          vsplit = '<C-c>v',
          split = '<C-c>i',
          tabe = '<C-c>t',
          quit = 'q',
        },
        rename_action_quit = "<C-c>",
        rename_in_select = true,
        -- show symbols in winbar must nightly
        -- in_custom mean use lspsaga api to get symbols
        -- and set it to your custom winbar or some winbar plugins.
        -- if in_cusomt = true you must set in_enable to false
        symbol_in_winbar = {
            in_custom = false,
            enable = false,
            separator = ' ',
            show_file = true,
            -- define how to customize filename, eg: %:., %
            -- if not set, use default value `%:t`
            -- more information see `vim.fn.expand` or `expand`
            -- ## only valid after set `show_file = true`
            file_formatter = "",
            click_support = false,
        },
        -- show outline
        show_outline = {
          win_position = 'right',
          --set special filetype win that outline window split.like NvimTree neotree
          -- defx, db_ui
          win_with = '',
          win_width = 30,
          auto_enter = true,
          auto_preview = true,
          virt_text = '┃',
          jump_key = 'o',
          -- auto refresh when change buffer
          auto_refresh = true,
        },
        -- custom lsp kind
        -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
        custom_kind = {},
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {},

      })
    end
  }

  -- }}} lsp

  use 'vim-denops/denops.vim'

  -- skk {{{
  -- use {
  --   -- 'vim-skk/denops-skkeleton.vim',
  --   'vim-skk/skkeleton',
  --   requires = { 'vim-denops/denops.vim' },
  --   config = function()
  --     vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = false })
  --     vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = false })
  --     --vim.cmd[[
  --     --  imap <C-j> <Plug>(skkeleton-enable)
  --     --  cmap <C-j> <Plug>(skkeleton-enable)
  --     --]]
  --     vim.cmd [[ call skkeleton#config({ 'eggLikeNewline':  v:true }) ]]
  --   end
  -- }
  -- }}} skk


  -- complete and snippet {{{
  use {
    'cohama/lexima.vim',
  }

  --  use {
  --    'Shougo/ddc.vim',
  --    requires = {
  --      -- 'LumaKernel/ddc-file', -- complete-source the file-name
  --      -- 'nvim-treesitter/nvim-treesitter',
  --      'hrsh7th/vim-vsnip-integ',
  --      'Shougo/pum.vim', -- popup
  --      -- 'Shougo/ddc-around', -- complete-source around the word
  --      'Shougo/ddc-source-around', -- complete-source around the word
  --      'Shougo/ddc-matcher_head', -- filter
  --      'Shougo/ddc-sorter_rank', -- sort
  --      'Shougo/ddc-converter_remove_overlap', -- protect double complete
  --      'Shougo/ddc-nvim-lsp', -- with lsp
  --      'Shougo/ddc-ui-native',
  --      --'tani/ddc-fuzzy', -- fuzzy-filter
  --      'vim-denops/denops.vim',
  --    },
  --    -- opt = true,
  --    -- event = 'InsertEnter',
  --    config = function()
  --      vim.fn["ddc#custom#patch_global"]('ui', 'native')
  --
  --      -- enable pum
  --      vim.fn["ddc#custom#patch_global"]('completionMenu', 'pum.vim')
  --
  --      -- use around source.
  --      -- vim.cmd [[ call ddc#custom#patch_global('sources', ['around',]) ]] -- default
  --      -- vim.fn["ddc#custom#patch_global"]('sources', {'nvim-lsp', 'skkeleton', 'around', 'vsnip', 'file', })
  --      -- vim.fn["ddc#custom#patch_global"]('sources', { 'vsnip', 'nvim-lsp', 'around', 'file', })
  --      vim.fn["ddc#custom#patch_global"]('sources', { 'vsnip', 'nvim-lsp', 'around', })
  --
  --      -- change source options.
  --      -- vim.fn["ddc#custom#patch_global"]('sourceOptions', {
  --      --   ['_'] = {
  --      --     -- ['matchers'] = {'matcher_head'},  -- default
  --      --     -- ['sortes'] = {'sorter_rank'},  -- default
  --      --     -- ['converters'] = {'converter_remove_overlap'},
  --      --     -- ['converters'] = {'converter_remove_overlap', 'converter_truncate', 'converter_fuzzy'},
  --      --     ['matchers'] = { 'matcher_fuzzy' },
  --      --     ['sortes'] = { 'sorter_fuzzy' },
  --      --     ['converters'] = { 'converter_remove_overlap', 'converter_fuzzy' },
  --      --     ['ignoreCase'] = true,
  --      --   },
  --      --   ['vsnip'] = { ['mark'] = 'vsnip', ['dup'] = true }, -- ['dup'] = true ?
  --      --   ['nvim-lsp'] = { ['mark'] = 'lsp', ['forceCompletionPattern'] = '\\.\\w*|:\\w*|->\\w*' },
  --      --   ['around'] = { ['mark'] = 'Around' },
  --      --   -- ['cmdline'] = { ['mark'] = 'cmd' }
  --      --   -- ['cmdline-history'] = { ['mark'] = 'hist', ['maxCandidates'] = 3 }
  --      --   ['skkeleton'] = {
  --      --     ['mark'] = 'skk',
  --      --     ['matchers'] = { 'skkeleton' },
  --      --     ['sorters'] = {},
  --      --     ['minAutoCompleteLength'] = 2,
  --      --   },
  --      --   ['file'] = {
  --      --     ['mark'] = 'F',
  --      --     ['isVolatile'] = true,
  --      --     ['forceCompletionPattern'] = '\\S/\\S*', -- '\S/\S*'
  --      --   }
  --      -- })
  --      -- vim.fn["ddc#custom#patch_global"]('sourceParams', {
  --      --   ['around'] = { ['maxSize'] = 500 },
  --      --   ['nvim-lsp'] = { ['kindLabels'] = { ['Class'] = 'c' } }
  --      -- })
  --      -- vim.fn["ddc#custom#patch_global"]('filterParams', {
  --      --   ['converter_truncate'] = { ['maxAbbrWidth'] = 60, ['maxInfo'] = 500, ['ellipsis'] = '...' },
  --      --   ['converter_fuzzy'] = { ['hlGroup'] = 'Title' }
  --      -- })
  --      -- vim.fn["ddc#custom#patch_filetype"](
  --      --   { 'ps1', 'dosbatch', 'autohotkey', 'registry' },
  --      --   {
  --      --     ['sourceOptions'] = {
  --      --       ['file'] = { ['forceCompletionPattern'] = '\\S\\\\\\S*', }, -- '\S\\\S*'
  --      --     },
  --      --     ['sourceParams'] = {
  --      --       ['file'] = { ['mode'] = 'win32', },
  --      --     }
  --      --   }
  --      -- )
  --
  --      -- -- unknown {{{
  --      -- vim.fn["pum#set_option"]('setline_insert', false)
  --      -- -- }}} unknown
  --
  --      -- -- enable textEdit with pum.vim
  --      -- --vim.cmd [[
  --      -- --  autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
  --      -- --]]
  --      -- vim.api.nvim_create_autocmd({ 'User' }, {
  --      --   pattern = 'PumCompleteDone',
  --      --   callback = function()
  --      --     vim.fn['vsnip_integ#on_complete_done'](vim.g['pum#completed_item'])
  --      --   end
  --      -- })
  --
  --
  --
  --      -- enable coplete command-line with pum {{{
  --      -- }}} enable coplete command-line with pum
  --
  --      -- enable ddc
  --      vim.fn["ddc#enable"]()
  --
  --      --      -- vim.cmd[[ inoremap <silent><expr> <TAB> pum#visible() ?
  --      --      --   \ '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  --      --      --   \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  --      --      --   \ '<TAB>' : ddc#manual_complete()
  --      --      -- \ ]]
  --      --      -- vim.cmd[[ inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR> ]]
  --
  --      -- <TAB>: completion.
  --      --      vim.cmd[[ inoremap <silent><expr> <TAB>
  --      --        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  --      --        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  --      --        \ '<TAB>' : ddc#manual_complete()
  --      --      \ ]]
  --      --vim.api.nvim_set_keymap('i', '<TAB>',
  --      --   vim.fn["pum#visible"]() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  --      --   (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  --      --   '<TAB>' : vim.fn["ddc#manual_complete"]()
  --      --   { noremap = true, silent = true, expr = true }
  --      --   )
  --      -- <S-TAB>: completion back
  --      vim.keymap.set('i', '<S-Tab>', '<Cmd>call pum#map#select_relative(-1)<CR>')
  --
  --      vim.keymap.set('i', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>')
  --      vim.keymap.set('i', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>')
  --      vim.keymap.set('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>')
  --      vim.keymap.set('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>')
  --    end
  --  }


  use {
    'matsui54/denops-popup-preview.vim',
    requires = { 'vim-denops/denops.vim' },
    config = function()

      -- use snippets
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- require'lspconfig'.clangd.setup{on_attach = on_attach, capabilities = capabilities}

      vim.g.popup_preview_config = { ['delay'] = 30, ['maxWidth'] = 100, ['winblend'] = 10, }
      vim.fn["popup_preview#enable"]()

    end
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
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
        experimental = {
          ghost_text = false,
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
          })
        }
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'path' }
        }
      })
    end
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'onsails/lspkind.nvim'

  use {
    'hrsh7th/vim-vsnip-integ',
    requires = { 'hrsh7th/vim-vsnip' }
  }

  use {
    'hrsh7th/vim-vsnip',
    requires = { 'rafamadriz/friendly-snippets' },
    config = function()
      -- Expand
      vim.cmd [[ imap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]]
      vim.cmd [[ smap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]]

      -- Expand or jump
      -- imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      -- smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      -- Jump forward or backward
      vim.cmd [[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
      vim.cmd [[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
      vim.cmd [[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]
      vim.cmd [[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]

      -- " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
      -- " See https://github.com/hrsh7th/vim-vsnip/pull/50
      -- nmap        s   <Plug>(vsnip-select-text)
      -- xmap        s   <Plug>(vsnip-select-text)
      -- nmap        S   <Plug>(vsnip-cut-text)
      -- xmap        S   <Plug>(vsnip-cut-text)
      --
      -- " If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
      -- let g:vsnip_filetypes = {}
      -- let g:vsnip_filetypes.javascriptreact = ['javascript']
      -- let g:vsnip_filetypes.typescriptreact = ['typescript']

    end
  }

  -- use {
  --   'ray-x/lsp_signature.nvim',
  --   requires = 'nvim-lspconfig'
  -- }


  -- }}} complete

  -- formatter/linter {{{
  --  use {
  --    "jose-elias-alvarez/null-ls.nvim",
  --    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --    config = function()
  --      local nulls = require"null-ls"
  --      nulls.config {
  --        sources = {
  --          nulls.builtins.formatting.prettier,
  --          nulls.builtins.formatting.rustfmt,
  --        },
  --      }
  --     require("lspconfig")["null-ls"].setup {}
  --    end
  --  }
  --  use {
  --    'mhartington/formatter.nvim',
  ----    -- opt = true,
  ----    cmd = "Format",
  --    config = function()
  --      require('formatter').setup({
  --        logging = false,
  --        filetype = {
  --          c = {
  --            function()
  --              return {
  --                exe = "clang-format",
  --                args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
  --                stdin = true,
  --                cwd = vim.fn.expand('%:p:h')
  --              }
  --            end
  --          },
  --          python = {
  --            function()
  --              return {
  --                exe = "black",
  --                args = { '-' },
  --                stdin = true
  --              }
  --            end
  --          },
  --          rust = {
  --            function()
  --              return {
  --                exe = "rustfmt",
  --                args = {"--emit=stdout"},
  --                stdin = true
  --              }
  --            end
  --          }
  --        }
  --      })
  --      vim.api.nvim_exec([[
  --        augroup FormatAutogroup
  --          autocmd!
  --          autocmd BufWritePost *.rs FormatWrite
  --        augroup END
  --      ]], true)
  --    end
  ----    -- nnoremap <silent> <leader>f :Format<CR>
  --  }
  -- }}} formatter/linter

  -- markdown preview {{{
  -- use {
  --   'kat0h/bufpreview.vim',
  --   requires = {'vim-denops/denops.vim' },
  --   opt = true,
  --   cmd = 'PreviewMarkdown',
  -- }
  -- use {
  --   'previm/previm',
  --   opt = true,
  --   cmd = 'PrevimOpen',
  --   config = function()
  --     vim.cmd [[let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe']]
  --     vim.cmd "let g:previm_wsl_mode = 1"
  --   end
  -- }
  -- }}}

  -- generate the image of the source code {{{
  --   use {
  --   'segeljakt/vim-silicon',
  --   opt = true,
  --   cmd = 'Silicon',
  --   config = function()
  --     vim.g.silicon = {
  --        theme: 'Dracula',
  --     }
  --   end
  --
  -- }
  --
  --   use {
  --   'skanehira/denops-germanium.vim',
  -- }
  -- }}}

  -- like easyemotion {{{
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    opt = true,
    --cmd = { 'HopChar1', 'HopChar2', 'Hop*' },
    keys = { { 'n', 'f' }, },
    config = function()
      require 'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
      vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
      vim.api.nvim_set_keymap('n', '<leader>hf', "<cmd>lua require'hop'.hint_char2()<cr>",
        { noremap = true, silent = false })
    end,
    --    -- config = function()
    --    --   require'hop.nvim'.setup { keys = 'etovxqpdygfblzhckisuran' }
    --    -- end,
    --    -- vim.api.nvim_set_keymap('n', '$', "<cmd>lua require'hop.nvim'.hint_words()<cr>", {})
    --    -- vim.api.nvim_set_keymap('n', '<leader>hf', "<cmd>lua require'hop.nvim'.hint_char2({ direction = require'hop.hint'AFTER_CURSOR, current_line_only = false, inclusive_jump=true})<cr>", {noremap=true, silent=true})
  }
  -- }}}

  -- show keymap {{{
  -- use 'folke/which-key.nvim'
  -- }}}

  -- rust {{{
  --  use {
  --    'simrat39/rust-tools.nvim',
  --    requires = 'nvim-lspconfig',
  --    opt = true,
  --    config = function()
  --      require('rust-tools').setup({
  --        tools = {  -- rust-tools options
  --          autoSetHints = true,
  --          hover_with_actions = true,
  --          inlay_hints = {
  --            show_parameter_hints = false,
  --            parameter_hints_prefix = "",
  --            other_hints_prefix = "",
  --          },
  --        },
  --        -- all the opts to send to nvim-lspconfig
  --        -- these override the defaults set by rust-tools.nvim
  --        server = {
  --          -- on_attach = on_attach,
  --          settings = {
  --            ["rust-analyzer"] = {
  --              checkOnSave = {
  --                command = "clippy",
  --              },
  --            },
  --          },
  --        }
  --      })
  --    end,
  --  }
  -- }}} rust

  -- dap {{{
  use {
    'mfussenegger/nvim-dap',
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local cwd = vim.fn.getcwd()
      local command = cwd .. '/.venv/bin/python'
      require('dap-python').setup(command)

      vim.fn.sign_define('DapBreakpoint', { text = '⛔', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })

      require('dapui').setup({
        layouts = {
          {
            elements = {
              { id = 'watches', size = 0.20 },
              { id = 'stacks', size = 0.20 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'scopes', size = 0.40 },
            },
            size = 64,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.20,
            position = 'bottom',
          },
        }
      })
      require('dap.ext.vscode').load_launchjs()


      vim.keymap.set('n', '<F5>', ':DapContinue<CR>', { silent = true })
      -- vim.keymap.set('n', '<F10>', ':DapStepOver<CR>', { silent = true })
      -- vim.keymap.set('n', '<F11>', ':DapStepInto<CR>', { silent = true })
      -- vim.keymap.set('n', '<F12>', ':DapStepOut<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>B',
      --   ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>lp',
      --   ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
      -- vim.keymap.set('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })

      vim.keymap.set('n', '<leader>d', ':lua require("dapui").toggle()<CR>')
      --vim.cmd [[command! -range DapUI :lua requjire("dapui").toggle()<CR>]]
    end,
  }

  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      local command = './.venv/bin/python'
      require('dap-python').setup(command)
    end,
  }
  --}}}


  -- filer {{{
  use {
    'lambdalisue/fern.vim',
    opt = true,
    cmd = 'Fern',
  }

  --  use {
  --    'Shougo/ddu.vim',
  --    requires = {
  --      'vim-denops/denops.vim',
  --    },
  --  }
  --
  --  use {
  --    'Shougo/ddu-ui-filer',
  --    requires = {
  --      'Shougo/ddu.vim',
  --      'Shougo/ddu-source-file',
  --      'Shougo/ddu-kind-file',
  --      'Shougo/ddu-column-filename',
  --    },
  --    config = function()
  --      vim.fn["ddu#custom#patch_local"]('filer', {
  --        ['ui'] = {'filer'},
  --        ['sources'] = [[
  --          {
  --            ['name'] = 'file',
  --            ['params'] = {},
  --          }
  --        ]],
  --        ['sourceOptions'] = { ['_'] = {['columns'] = [['filename']] }, },
  --        ['kindOptions'] = { ['file'] = {['defaultAction'] = 'open' }, },
  --        ['uiParams'] = { ['filer'] = {
  --          ['winWidth'] = 40,
  --          ['split'] = 'vertical',
  --          ['splitDirection'] = 'topleft',
  --        }, },
  --      })
  --
  --    --  --vim.cmd[[
  --    --  --  autocmd TabEnter,CursorHold,FocusGained <buffer> call ddu#ui#filer#do_action('checkItems')
  --    --  --]]
  --    end
  --
  --  -- run = ':lua require("telekasten")',
  --  -- }
  --  }
  -- }}} filer

end)
