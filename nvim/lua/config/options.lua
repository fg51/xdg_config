vim.cmd("autocmd!")

local g = vim.g
local o, wo, bo = vim.o, vim.wo, vim.bo
local cmd = vim.cmd
local opt = vim.opt

-- local utils = require 'config.utils'
-- local autocmd = utils.autocmd
-- local map = utils.map

-- local buffer = {o, bo}
-- local window = {o, wo}

-- # INITIALIZE {{{

-- {{{ disable builtin plugins
--g.did_install_default_menus = 1
--g.did_install_syntax_menu   = 1
--g.loaded_2html_plugin       = 1
--g.loaded_getscript          = 1
--g.loaded_getscriptPlugin    = 1
--g.loaded_gzip               = 1
--g.loaded_logiPat            = 1
--g.loaded_man                = 1
--g.loaded_matchit            = 1
--g.loaded_matchparen         = 1
--g.loaded_rrhelper           = 1
--g.loaded_tar                = 1
--g.loaded_tarPlugin          = 1
--g.loaded_tutor_mode_plugin  = 1
--g.loaded_vimball            = 1
--g.loaded_vimballPlugin      = 1
--g.loaded_zip                = 1
--g.loaded_zipPlugin          = 1
--g.skip_loading_mswin        = 1
--g.loaded_netrw              = 1 -- instead of useing 'nvim-telescope/telescope.nvim'
--g.loaded_netrwPlugin        = 1
--g.loaded_netrwSettings      = 1

-- g.did_load_filetypes = 1 -- instead of using nathom/filetype.nvim
-- }}}

-- {{{ neovim provider
-- {{{ python3, python2
-- g.python_host_prog = '~/.anyenv/envs/pyenv/versions/neovim2/bin/python2'
--g.python3_host_prog = '~/.anyenv/envs/pyenv/versions/neovim3/bin/python3'
g.python3_host_prog = vim.env.HOME .. "/.local/share/nvim_python3_host/.venv/bin/python3"
-- }}}

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0

-- }}}

-- opt.fileencoding
cmd("set foldcolumn=1") -- fold

opt.autoindent = true -- indent
opt.autoread = true -- buffer -- cmd "set autoread"
opt.clipboard:append({ "unnamedplus" }) -- input --set clipboard=unnamed
opt.cmdheight = 3 -- view --cmd "set cmdheight=3" --set cmdheight=3
opt.cursorcolumn = false -- view -- cmd "set nocursorcolumn"
opt.display = "lastline" -- view -- cmd "set display=lastline" --set display=lastline "NOTE: no-@ in long line
-- opt.expandtab = true -- indent  -- priority to editorconfig
opt.foldlevel = 99 -- fold
opt.foldmethod = "marker" -- fold
opt.hidden = false -- buufer -- disable unsaved file. -- set nohidden
opt.hlsearch = true -- search
opt.ignorecase = true -- search
opt.laststatus = 2 -- view -- cmd "set laststatus=2" --set laststatus=2
opt.list = true -- view -- show invisible chars cmd "set list" --set list
opt.mouse = "a" -- cmd "set mouse=a" --set mouse=a
opt.scrolloff = 5 -- view set scrolloff=5
-- opt.shiftwidth = 2 -- indent  -- priority to editorconfig
opt.showcmd = true -- view cmd "set showcmd" --set showcmd
opt.showtabline = 2 -- view -- cmd "set showtabline=2" --set showtabline=2
opt.smartcase = true -- search --  Don't ignore case with capitals
opt.smartindent = true -- indent
opt.smarttab = true -- indent
-- opt.softtabstop = 2 -- indent --bo.softtabstop = 2  -- priority to editorconfig
-- opt.tabstop = 2 -- indent  -- priority to editorconfig
opt.termguicolors = true --  true use 24bit color. set termguicolors
opt.title = true -- cmd "set title"  --set title
opt.virtualedit:append({ "block" }) -- input -- set virtualedit& virtualedit+=block
opt.wrap = true -- view -- cmd "set wrap"
opt.writebackup = false -- buffer --set nowritebackup

wo.cursorline = false -- view --set nocursorline
wo.number = true -- view -- show line-number
wo.relativenumber = false -- view -- cmd "set norelativenumber"
wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

cmd("set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%")
-- o.listchars = {
--   tab = '»-',
--   trail = '-',
--   extends = '»',
--   precedes = '«',
--   nbsp = '%',
-- }

cmd("set fillchars=stl:\\ ,stlnc:\\ ,vert:\\|,fold:-,diff:-") -- set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
cmd("let g:vim_indent_cont = 0") --let g:vim_indent_cont = 0
cmd("set backspace=indent,eol,start") -- input -- set backspace=indent,eol,start

--" ## BUFFER {{{

--"set noswapfile
--set fileencodings=utf-8,default,ucs-bom,euc-jp,cp932,shift-jis,latin1

--if g:is_windows
--  set directory=c:/tmp/swap,c:/temp/swap
--  set backupdir=c:/tmp/swap,c:/temp/swap
--  set undodir=c:/tmp/undo,c:/temp/undo
--else
cmd("set directory=~/.cache/vim/swap") --  set directory=~/.cache/vim/swap
cmd("set undofile undodir=~/.cache/vim/undo") --  set undofile undodir=~/.cache/vim/undo
--endif
-- }}} BUFFER

-- ## VIEW {{{

--"set textwidth=0 "NOTE: auto by-return

-- NOTE: simple statuline
--"set statusline=%f%M%R%H%W%q%{&ff=='unix'?'':',['.&ff.']'}%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}%{GetQuickFixCount()==0?'':'\ [!'.GetQuickFixCount().']'}%=%(\|%3p%%%)
--"set statusline=%f%M%R%H%W%q
--"set statusline+=%{&ff=='unix'?'':',['.&ff.']'}
--"set statusline+=%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}
--"set statusline+=%{GetQuickFixCount()==0?'':'\ [!'.GetQuickFixCount().']'}
--"set statusline+=%=%(\|%3p%%%)
--"function! GetQuickFixCount() abort
--"  return len(filter(getqflist(), 'v:val.valid != 0'))
--"endfunction

-- }}} VIEW

-- ## COMMAND {{{
opt.wildmenu = true --cmd "set wildmenu" --set wildmenu  -- complete in the commandline mode.
opt.wildmode = { "longest", "full" } --set wildmode=longest:full,full
opt.wildignore = { "*.o", "*.a", "*.pyc", "__pycache__", "node_modules" }
o.history = 2000 -- cmd "set history=2000" --set history=2000
-- cmd "set nostartofline" --set nostartofline
opt.startofline = false
--}}} COMMAND

--}}} VIM OPTIONS


-- vim.api.nvim_create_autocmd({'BufWritePost'})

-- OTHERS {{{
--" no scrach(preview)
-- }}} OTHERS

o.synmaxcol = 200

o.updatetime = 300 -- any [msec] until creating the swap file
o.timeout = true -- set timeout -- for mappings
o.timeoutlen = 1000 -- set timeoutlen=1000 -- default value
o.ttimeout = true -- set ttimeout -- for key codes
o.ttimeoutlen = 10 -- set ttimeoutlen=10 -- unnoticeable small value

-- ### complete {{{
-- opt.completeopt = "menu,menuone,noselect"
opt.completeopt = "menu,menuone,noselect"
-- cmd "set completeopt-=preview" --set completeopt-=preview
-- }}} complet
-- opt.completeopt = ""
-- opt.completeopt = "preview"
-- opt.completeopt = "menuone,noinsert,noselect"
-- * menuone: display menu at one
-- * noinsert: disable insert with displaying menu
cmd("set completeopt-=preview")
opt.shortmess:append("c") --cmd "set shortmess+=c"

opt.showmatch = true
opt.matchtime = 1
cmd("set matchpairs& matchpairs+=<:>") --  set nocompatible

opt.formatoptions:append({ "r" })

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.o.shortmess = "filnxtToOFWIcC"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Restore cursor location when file is opened
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})
-- opt.guifont = "font-name:h11"
