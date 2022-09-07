vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- packer can mange itself
  use 'wbthomason/packer.nvim'

  -- detect filetype faster
  use {
    'nathom/filetype.nvim',
    config = require("filetype").setup({
      overrides = {
        extensions = {
          -- Set the filetype of *.pn files to potion
          pn = "potion",
        },
        literal = {
          -- Set the filetype of files named "MyBackupFile" to lua
          MyBackupFile = "lua",
        },
        complex = {
          -- Set the filetype of any full filename matching the regex to gitconfig
          [".*git/config"] = "gitconfig", -- Included in the plugin
        },

        -- The same as the ones above except the keys map to functions
        function_extensions = {
          ["cpp"] = function()
            vim.bo.filetype = "cpp"
            -- Remove annoying indent jumping
            vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
          end,
          ["pdf"] = function()
            vim.bo.filetype = "pdf"
            -- Open in PDF viewer (Skim.app) automatically
            vim.fn.jobstart(
              "open -a skim " .. '"' .. vim.fn.expand("%") .. '"'
            )
          end,
        },
        function_literal = {
          Brewfile = function()
            vim.cmd("syntax off")
          end,
        },
        function_complex = {
          ["*.math_notes/%w+"] = function()
            vim.cmd("iabbrev $ $$")
          end,
        },

        shebang = {
          -- Set the filetype of files with a dash shebang to sh
          dash = "sh",
        },
      },
    })
  }


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
    config = require 'nvim-treesitter.configs'.setup {
      -- ensure_installed = 'maintained',
      -- ensure_installed = {"c", "lua", "rust" },
      -- install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = { "javascript" },

      highlight = { enable = true },
      -- refactor = {
      --   highlight_definitions = {
      --     enable = true
      --   },
      --   smart_rename = {
      --     enable = true,
      --     smart_rename = 'grr',
      --   },
      --   navigation = {
      --     enable = true,
      --     goto_definition = 'gnd',
      --     list_definitions = 'gnD'
      --   }
      -- },
      indent = { enable = true, },
      autotag = { enable = true, },
    }
  }
  --use {
  --  'sheerun/vim-polyglot', config = function() vim.cmd "let g:rustfmt_autosave = 1" end
  --}

  -- filetype {{{
  use { 'sirtaj/vim-openscad', ft = 'scad' }
  use { 'ron-rs/ron.vim', ft = 'ron' }
  -- }}} filetype

  -- theme {{{
  --use { 'navarasu/onedark.nvim',
  --  -- requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
  --  --config = function() vim.cmd "colorscheme onedark" end
  --  config = function()
  --    onedark = require('onedark')
  --    onedark.setup({
  --      transparent = false,
  --    })
  --    -- onedark.load()
  --  end
  --}

  use { 'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true
        },
        on_attach = vim.cmd("colorscheme duskfox"),
      })
    end,
    --setup = function()
    --  vim.cmd("colorscheme duskfox")
    --end
  }

  -- }}} theme

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

  -- status line {{{
  -- use {
  --  'glepnir/galaxyline.nvim',
  --  branch = 'main',
  --  requires = {'kyazdani42/nvim-web-devicons', opt = true },
  --}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      -- 'EdenEast/nightfox.nvim',
      opt = true
    },
    config = require('lualine').setup {
      options = {
        theme = 'nord',
      },
      sections = {
        lualine_x = {
          { 'encoding' },
          { 'fileformat', icons_enabled = false, },
          { 'filetype', icons_enabled = false, }
        }
      }
    }
  }

  -- }}} statusline

  -- finder {{{
  use { 'nvim-telescope/telescope.nvim', opt = true, cmd = 'Telescope', requires = { { 'nvim-lua/plenary.nvim' } } }
  -- }}} finder

  -- lsp {{{
  use {
    'williamboman/mason.nvim',
    -- cmd = {'Mason', 'MasonInstall', 'Mason*'},
    -- config = function()
    --   require('mason').setup()
    -- end
  }

  -- use { "neovim/nvim-lspconfig", }

  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    -- opt = true,
    --event = 'BufEnter',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({ function(server)
        --       local opt = {
        --       -- -- Function executed when the LSP server startup
        --       -- on_attach = function(client, bufnr)
        --       --   local opts = { noremap=true, silent=true }
        --       --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        --       --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
        --       -- end,
        --       -- capabilities = require('cmp_nvim_lsp').update_capabilities(
        --       --   vim.lsp.protocol.make_client_capabilities()
        --       -- )
        --       }
        --     require('lspconfig')[server].setup(opt)

        local opt = {
          -- Function executed when the LSP server startup
          on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Enable completion triggered by <c-x><c-o>
            -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings
            local mopts = { noremap = true, silent = true }

            buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', mopts)
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', mopts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', mopts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', mopts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', mopts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', mopts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
              mopts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', mopts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', mopts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', mopts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', mopts)
            buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', mopts)
            buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', mopts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', mopts)
            buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', mopts)

            --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
            -- format on save
            -- vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync() ]]
            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                group = vim.api.nvim_create_augroup('Format', { clear = true }),
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.formatting_seq_sync()
                end,
              })
            end

            -- Reference highlight
            -- vim.cmd [[
            --   set updatetime=500
            --   highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
            --   highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
            --   highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
            --   augroup lsp_document_highlight
            --     autocmd!
            --     autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
            --     autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
            --   augroup END
            -- ]]

          end
        }
        require('lspconfig')[server].setup(opt)
      end })


      --   end

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

  use {
    'Shougo/ddc.vim',
    requires = {
      'LumaKernel/ddc-file', -- complete-source the file-name
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/vim-vsnip-integ',
      'Shougo/pum.vim', -- popup
      'Shougo/ddc-around', -- complete-source around the word
      'Shougo/ddc-matcher_head', -- filter
      'Shougo/ddc-sorter_rank', -- sort
      'Shougo/ddc-converter_remove_overlap', -- protect double complete
      'Shougo/ddc-nvim-lsp', -- with lsp
      'tani/ddc-fuzzy', -- fuzzy-filter
      'vim-denops/denops.vim',
    },
    -- opt = true,
    -- event = 'InsertEnter',
    config = function()
      -- enable pum
      vim.fn["ddc#custom#patch_global"]('completionMenu', 'pum.vim')

      -- vim.cmd[[ call ddc#custom#patch_global('sources', ['around',]) ]] -- default
      -- vim.fn["ddc#custom#patch_global"]('sources', {'nvim-lsp', 'skkeleton', 'around', 'vsnip', 'file', })
      vim.fn["ddc#custom#patch_global"]('sources', { 'vsnip', 'nvim-lsp', 'around', 'file', })

      vim.fn["ddc#custom#patch_global"]('sourceOptions', {
        ['_'] = {
          -- ['matchers'] = {'matcher_head'},  -- default
          -- ['sortes'] = {'sorter_rank'},  -- default
          -- ['converters'] = {'converter_remove_overlap'},
          -- ['converters'] = {'converter_remove_overlap', 'converter_truncate', 'converter_fuzzy'},
          ['matchers'] = { 'matcher_fuzzy' },
          ['sortes'] = { 'sorter_fuzzy' },
          ['converters'] = { 'converter_remove_overlap', 'converter_fuzzy' },
          ['ignoreCase'] = true,
        },
        ['vsnip'] = { ['mark'] = 'vsnip', ['dup'] = true }, -- ['dup'] = true ?
        ['nvim-lsp'] = { ['mark'] = 'lsp', ['forceCompletionPattern'] = '\\.\\w*|:\\w*|->\\w*' },
        ['around'] = { ['mark'] = 'Around' },
        -- ['cmdline'] = { ['mark'] = 'cmd' }
        -- ['cmdline-history'] = { ['mark'] = 'hist', ['maxCandidates'] = 3 }
        ['skkeleton'] = {
          ['mark'] = 'skk',
          ['matchers'] = { 'skkeleton' },
          ['sorters'] = {},
          ['minAutoCompleteLength'] = 2,
        },
        ['file'] = {
          ['mark'] = 'F',
          ['isVolatile'] = true,
          ['forceCompletionPattern'] = '\\S/\\S*', -- '\S/\S*'
        }
      })
      vim.fn["ddc#custom#patch_global"]('sourceParams', {
        ['around'] = { ['maxSize'] = 500 },
        ['nvim-lsp'] = { ['kindLabels'] = { ['Class'] = 'c' } }
      })
      vim.fn["ddc#custom#patch_global"]('filterParams', {
        ['converter_truncate'] = { ['maxAbbrWidth'] = 60, ['maxInfo'] = 500, ['ellipsis'] = '...' },
        ['converter_fuzzy'] = { ['hlGroup'] = 'Title' }
      })
      vim.fn["ddc#custom#patch_filetype"](
        { 'ps1', 'dosbatch', 'autohotkey', 'registry' },
        {
          ['sourceOptions'] = {
            ['file'] = { ['forceCompletionPattern'] = '\\S\\\\\\S*', }, -- '\S\\\S*'
          },
          ['sourceParams'] = {
            ['file'] = { ['mode'] = 'win32', },
          }
        }
      )

      -- unknown {{{
      vim.fn["pum#set_option"]('setline_insert', false)
      -- }}} unknown

      -- enable textEdit with pum.vim
      --vim.cmd [[
      --  autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
      --]]
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'PumCompleteDone',
        callback = function()
          vim.fn['vsnip_integ#on_complete_done'](vim.g['pum#completed_item'])
        end
      })



      -- enable coplete command-line with pum {{{
      -- }}} enable coplete command-line with pum

      -- enable ddc
      vim.fn["ddc#enable"]()

      --      -- vim.cmd[[ inoremap <silent><expr> <TAB> pum#visible() ?
      --      --   \ '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      --      --   \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      --      --   \ '<TAB>' : ddc#manual_complete()
      --      -- \ ]]
      --      -- vim.cmd[[ inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR> ]]

      -- <TAB>: completion.
      --      vim.cmd[[ inoremap <silent><expr> <TAB>
      --        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      --        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      --        \ '<TAB>' : ddc#manual_complete()
      --      \ ]]
      --vim.api.nvim_set_keymap('i', '<TAB>',
      --   vim.fn["pum#visible"]() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      --   (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      --   '<TAB>' : vim.fn["ddc#manual_complete"]()
      --   { noremap = true, silent = true, expr = true }
      --   )
      -- <S-TAB>: completion back
      vim.keymap.set('i', '<S-Tab>', '<Cmd>call pum#map#select_relative(-1)<CR>')

      vim.keymap.set('i', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>')
      vim.keymap.set('i', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>')
      vim.keymap.set('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>')
      vim.keymap.set('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>')
    end
  }


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

  use {
    'ray-x/lsp_signature.nvim',
    requires = 'nvim-lspconfig'
  }


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
    cmd = { 'Hop*' },
    config = function()
      require 'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
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
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '⛔', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
      require('dapui').setup({
        layouts = {
          {
            elements = {
              { id = 'watches', size = 0.20 },
              { id = 'stacks', size = 0.20 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'scopes', size = 0.20 },
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

      -- vim.keymap.set('n', '<F5>', ':DapContinue<CR>', { silent = true })
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

      -- vim.keymap.set('n', '<leader>d', ':lua require("dapui").toggle()<CR>')
    end,
  }

  --}}}

  -- zettelkasten {{{
  -- use {
  --   'renerocksai/telekasten.nvim',
  --   requires = {
  --     'nvim-telescope/telescope.nvim'
  --   },
  --   -- opt = true,
  --   -- run = ':lua require("telekasten")',
  -- }
  -- }}} zettelkasten


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
