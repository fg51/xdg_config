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
    --requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    --config = function() vim.cmd "colorscheme onedark" end
    config = require('onedark').setup()
  }

-- use { 'sainnhe/sonokai',  cmd "let g:edge_style = ''" }
-- use { 'sainnhe/edge', cmd "let g:edge_style = ''" }
-- }}}

  use 'editorconfig/editorconfig-vim'


  -- use 'vim-scripts/gtags.vim'

  use 'tpope/vim-surround'


  use { 'h1mesuke/vim-alignta', opt = true, cmd = 'Alignta' }


--# GIT {{{
--[[plugins]]
--repo = 'tpope/vim-fugitive'
--on_cmd=['Gstatus', 'Gwrite', 'Gread', 'Gcommit', 'Gdiff', 'Gvdiff']

--[[plugins]]
--repo = 'airblade/vim-gitgutter'
--on_event=['VimEnter']
--# }}} GIT


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
    config = require'lualine'.setup {
      options = {
        theme = 'onedark'
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
  use {'nvim-telescope/telescope.nvim', opt = true, cmd = 'Telescope', requires = { { 'nvim-lua/plenary.nvim' } } }
-- }}} finder

-- lsp {{{
  use "williamboman/nvim-lsp-installer"
  use {
    "neovim/nvim-lspconfig",
    requires = {'hrsh7th/cmp-nvim-lsp', opt = true },
    config = function()
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

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
        buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end

      local lsp_installer = require("nvim-lsp-installer")
      lsp_installer.on_server_ready(function(server)
          local opts = {}
          opts.on_attach = on_attach
          -- for nvim-cmp {{{
          opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
          -- }}} end nvim-cmp

          server:setup(opts)
          vim.cmd [[ do User LspAttachBuffers ]]
      end)
    end
  }
-- }}} lsp


-- skk {{{
  use {
    'vim-skk/denops-skkeleton.vim',
    requires = { 'vim-denops/denops.vim' },
    config = function()
        -- vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-enable)")
        -- vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-enable)")
        vim.cmd[[
          imap <C-j> <Plug>(skkeleton-enable)
          cmap <C-j> <Plug>(skkeleton-enable)
        ]]
      end
    -- config = require'lualine'.setup {
    --   options = {
    --     theme = 'onedark'
    --   },
    --   sections = {
    --     lualine_x = {
    --       { 'encoding' },
    --       { 'fileformat', icons_enabled = false, },
    --       { 'filetype', icons_enabled = false, }
    --     }
    --   }
    -- }
  }
-- }}}

-- complete {{{
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'


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
  use {
    'mhartington/formatter.nvim',
--    -- opt = true,
--    cmd = "Format",
    config = function()
      require('formatter').setup({
        logging = false,
        filetype = {
          rust = {
            function()
              return {
                exe = "rustfmt",
                args = {"--emit=stdout"},
                stdin = true
              }
            end
          }
        }
      })
      vim.api.nvim_exec([[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.rs FormatWrite
        augroup END
      ]], true)
    end
--    -- nnoremap <silent> <leader>f :Format<CR>
  }
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
    end,
--    -- config = function()
--    --   require'hop.nvim'.setup { keys = 'etovxqpdygfblzhckisuran' }
--    -- end,
--    -- vim.api.nvim_set_keymap('n', '$', "<cmd>lua require'hop.nvim'.hint_words()<cr>", {})
  }
-- }}}

-- show keymap {{{
  -- use 'folke/which-key.nvim'
-- }}}


end)
