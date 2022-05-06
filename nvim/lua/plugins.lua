vim.cmd[[packadd packer.nvim]]


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
    config = require'nvim-treesitter.configs'.setup {
      highlight = { enable = true },
      refactor = {
        highlight_definitions = {
          enable = true
        },
        smart_rename = {
          enable = true,
          smart_rename = 'grr',
        },
        navigation = {
          enable = true,
          goto_definition = 'gnd',
          list_definitions = 'gnD'
        }
      },
      ensure_installed = 'maintained',
    }
  }
  --use {
  --  'sheerun/vim-polyglot', config = function() vim.cmd "let g:rustfmt_autosave = 1" end
  --}

-- filetype {{{
  use { 'sirtaj/vim-openscad' } -- , ft = 'scad' }

  use { 'ron-rs/ron.vim' } --, ft = 'ron' }
-- }}} filetype

-- theme {{{
  use { 'navarasu/onedark.nvim',
    -- requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    --config = function() vim.cmd "colorscheme onedark" end
    config = function()
      onedark = require('onedark')
      onedark.setup({
        transparent = true,
      })
      onedark.load()
    end
  }

-- use { 'sainnhe/sonokai',  cmd "let g:edge_style = ''" }
-- use { 'sainnhe/edge', cmd "let g:edge_style = ''" }
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
    cmd = {'Gina'},
  }

  use {
    'airblade/vim-gitgutter',
    opt = true,
    event = 'VimEnter',
  }
--  --# }}} GIT


  use { 'mattn/emmet-vim', ft = {'css', 'html', 'javascript', 'markdown', 'typescript',  } }

-- status line {{{
   -- use {
   --  'glepnir/galaxyline.nvim',
   --  branch = 'main',
   --  requires = {'kyazdani42/nvim-web-devicons', opt = true },
   --}
   use {
     'nvim-lualine/lualine.nvim',
     requires = { 'kyazdani42/nvim-web-devicons', opt = true },
     config = require('lualine').setup {
       -- options = {
       --   theme = 'onedark'
       -- },
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
  use {'nvim-telescope/telescope.nvim', opt = true, cmd = 'Telescope', requires = { { 'nvim-lua/plenary.nvim' } } }
-- }}} finder

-- lsp {{{
  use {
    "williamboman/nvim-lsp-installer",
    requires = { "neovim/nvim-lspconfig", }
  }

  use {
    "neovim/nvim-lspconfig",
    -- requires = {'hrsh7th/cmp-nvim-lsp', opt = true },
    requires = { "williamboman/nvim-lsp-installer" },
    opt = true,
    event = 'BufEnter',
    config = function()

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local opts = { noremap=true, silent=true }

        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      local servers = { 'pyright', 'tsserver' }
      for _, lsp in ipairs(servers) do
         require('lspconfig')[lsp].setup {
           on_attach = on_attach,
           flags = {
             debounce_text_changes = 150,
           }
         }
      end

      -- local virtual_env_path = vim.trim(vim.fn.system('poetry config virtualenvs.path'))
      -- local virtual_env_directory = vim.trim(vim.fn.system('poetry env list'))
      -- local python_path = 'python'
      -- if #vim.split(virtual_env_directory, '\n') == 1 then
      --   python_path = string.format("%s/%s/bin/python", virtual_env_path, virtual_env_directory)
      -- end
      -- require('lspconfig')['pyright'].setup {
      --   on_attach = on_attach,
      --   flags = {
      --     debounce_text_changes = 150,
      --   },
      --   settings = {
      --     python = {
      --       pythonPath = python_path;
      --     }
      --   }
      -- }

      require('lspconfig')['rust_analyzer'].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirFromCheck = true
            },
            procMacro = {
              enable = true
            },
            checkOnSave = {
             command = "clippy"
            },
          }
        }
      }
      local lsp_installer = require("nvim-lsp-installer")
      lsp_installer.on_server_ready(function(server)
        local opts = {}
        opts.on_attach = on_attach
        -- for nvim-cmp {{{
        -- opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        -- }}} end nvim-cmp
        -- server:setup(opts)


        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end)

      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  }
-- }}} lsp

  use 'vim-denops/denops.vim'

-- skk {{{
  use {
    -- 'vim-skk/denops-skkeleton.vim',
    'vim-skk/skkeleton',
    requires = { 'vim-denops/denops.vim' },
    config = function()
      vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-enable)", {noremap = false})
      vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-enable)", {noremap = false})
      --vim.cmd[[
      --  imap <C-j> <Plug>(skkeleton-enable)
      --  cmap <C-j> <Plug>(skkeleton-enable)
      --]]
      vim.cmd[[ call skkeleton#config({ 'eggLikeNewline':  v:true }) ]]
    end
  }
-- }}} skk


-- complete and snippet {{{
  use {
    'Shougo/ddc.vim',
    requires = {
      'vim-denops/denops.vim',
      'Shougo/pum.vim',  -- popup
      'Shougo/ddc-around',  -- complete-source around the word
      'LumaKernel/ddc-file',  -- complete-source the file-name
      'Shougo/ddc-matcher_head',  -- fileter
      'tani/ddc-fuzzy',  -- fuzzy-filter
      'Shougo/ddc-sorter_rank',  -- sort
      'Shougo/ddc-converter_remove_overlap', -- protect double complete
      'Shougo/ddc-nvim-lsp',  -- with lsp
      'hrsh7th/vim-vsnip-integ',
    },
    -- opt = true,
    -- event = 'InsertEnter',
    config = function()
      -- enable pum
      vim.fn["ddc#custom#patch_global"]('completionMenu', 'pum.vim')

      -- vim.cmd[[ call ddc#custom#patch_global('sources', ['around',]) ]] -- default
      vim.fn["ddc#custom#patch_global"]('sources', {'nvim-lsp', 'skkeleton', 'around', 'vsnip', 'file', })

      vim.fn["ddc#custom#patch_global"]('sourceOptions', {
        ['_'] = {
          -- ['matchers'] = {'matcher_head'},  -- default
          -- ['sortes'] = {'sorter_rank'},  -- default
          -- ['converters'] = {'converter_remove_overlap'},
          -- ['converters'] = {'converter_remove_overlap', 'converter_truncate', 'converter_fuzzy'},
          ['matchers'] = {'matcher_fuzzy' },
          ['sortes'] = {'sorter_fuzzy'},
          ['converters'] = {'converter_remove_overlap', 'converter_fuzzy'},
          ['ignoreCase'] = true,
        },
        ['vsnip'] = {['mark'] = 'vsnip' },  -- ['dup'] = true ?
        ['nvim-lsp'] = { ['mark'] = 'lsp', ['forceCompletionPattern'] = '\\.\\w*|:\\w*|->\\w*' },
        ['around'] = {['mark'] = 'Around' },
        -- ['cmdline'] = { ['mark'] = 'cmd' }
        -- ['cmdline-history'] = { ['mark'] = 'hist', ['maxCandidates'] = 3 }
        ['skkeleton'] = {
          ['mark'] = 'skk',
          ['matchers'] = {'skkeleton'},
          ['sorters'] = {},
          ['minAutoCompleteLength'] = 2,
        },
        ['file'] = {
          ['mark'] = 'F',
          ['isVolatile'] = true,
          ['forceCompletionPattern'] = '\\S/\\S*',  -- '\S/\S*'
        }
      })
      vim.fn["ddc#custom#patch_global"]('sourceParams', {
        ['around'] = { ['maxSize'] = 500 },
        ['nvim-lsp'] = { ['kindLabels'] = { ['Class'] = 'c' } }
      })
      vim.fn["ddc#custom#patch_global"]('filterParams', {
        ['converter_truncate'] = { ['maxAbbrWidth'] = 60, ['maxInfo'] = 500, ['ellipsis'] = '...'},
        ['converter_fuzzy'] = { ['hlGroup'] = 'Title' }
      })
      vim.fn["ddc#custom#patch_filetype"](
        {'ps1', 'dosbatch', 'autohotkey', 'registry'},
        {
          ['sourceOptions'] = {
            ['file'] = { ['forceCompletionPattern'] = '\\S\\\\\\S*',  },  -- '\S\\\S*'
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
      vim.cmd[[
        autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
      ]]


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
      vim.api.nvim_set_keymap('i', '<S-Tab>', '<Cmd>call pum#map#select_relative(-1)<CR>', {noremap = true})

      -- vim.cmd[[ inoremap <C-n> <Cmd>call pum#map#select_relative(+1)<CR> ]]
      vim.api.nvim_set_keymap('i', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>', {noremap = true})
      -- vim.cmd[[ inoremap <C-p> <Cmd>call pum#map#select_relative(-1)<CR> ]]
      vim.api.nvim_set_keymap('i', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>', {noremap = true})
      -- vim.cmd[[ inoremap <C-y> <Cmd>call pum#map#confirm()<CR> ]]
      vim.api.nvim_set_keymap('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', {noremap = true})
      -- vim.cmd[[ inoremap <C-e> <Cmd>call pum#map#cancel()<CR> ]]
      vim.api.nvim_set_keymap('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', {noremap = true})


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
    config = function()
      -- Expand
      vim.cmd[[ imap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]]
      vim.cmd[[ smap <expr> <C-l>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>' ]]

      -- Expand or jump
-- imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
-- smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      -- Jump forward or backward
      vim.cmd[[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
      vim.cmd[[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
      vim.cmd[[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]
      vim.cmd[[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]

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

  use { 'rafamadriz/friendly-snippets' }

  use { 'tani/ddc-fuzzy' }



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
    branch = 'v1',
    opt = true,
    cmd = { 'HopWord', 'HopPattern', 'HopChar1', 'HopChar2', 'HopLine' },
    config = function()
      require'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
      vim.api.nvim_set_keymap('n', '<leader>hf', "<cmd>lua require'hop'.hint_char2()<cr>", {noremap=true, silent=false})
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

-- filer {
  use {
    'lambdalisue/fern.vim',
    opt = true,
    cmd = 'Fern',
  }
-- }

end)
