local g = vim.g
local o, wo, bo = vim.o, vim.wo, vim.bo
local cmd = vim.cmd
local opt = vim.opt

-- local utils = require 'config.utils'
-- local autocmd = utils.autocmd
-- local map = utils.map

-- local buffer = {o, bo}
-- local window = {o, wo}


--if 0 | endif

-- # INITIALIZE {{{

--if &compatible
-- cmd "set nocompatible"  --  set nocompatible
--endif

--augroup myautocmd
--  autocmd!
--augroup END


-- ## conditions {{{

--let g:is_windows = has('win32') || has('win64')
--let g:is_gui = has('gui_running')
--let g:is_terminal = !g:is_gui
--let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8')
--    \ && !(exists('g:discard_unicode') && g:discard_unicode != 0)
-- }}} conditions
--  o.is_windows = false
-- if os.execute('uname -a | grep microsoft') ~= '' then
--  o.is_windows = true
-- end

-- must be set with multibyte strings
--scriptencoding utf-8
-- }}} INITIALIZE

-- {{{ disable builtin plugins
g.did_install_default_menus = 1
g.did_install_syntax_menu   = 1
g.loaded_2html_plugin       = 1
g.loaded_getscript          = 1
g.loaded_getscriptPlugin    = 1
g.loaded_gzip               = 1
g.loaded_logiPat            = 1
g.loaded_man                = 1
g.loaded_matchit            = 1
g.loaded_matchparen         = 1
g.loaded_rrhelper           = 1
g.loaded_tar                = 1
g.loaded_tarPlugin          = 1
g.loaded_tutor_mode_plugin  = 1
g.loaded_vimball            = 1
g.loaded_vimballPlugin      = 1
g.loaded_zip                = 1
g.loaded_zipPlugin          = 1
g.skip_loading_mswin        = 1
g.loaded_netrw              = 1 -- instead of useing 'nvim-telescope/telescope.nvim'
g.loaded_netrwPlugin        = 1
g.loaded_netrwSettings      = 1

g.did_load_filetypes = 1 -- instead of using nathom/filetype.nvim
-- }}}

-- {{{ neovim provider
-- {{{ python3, python2
g.python_host_prog = '~/.anyenv/envs/pyenv/versions/neovim2/bin/python2'
--g.python3_host_prog = '~/.anyenv/envs/pyenv/versions/neovim3/bin/python3'
g.python3_host_prog = vim.env.HOME .. '/.local/share/nvim_python3_host/.venv/bin/python3'
-- }}}

g.loaded_node_provider = 0
g.loaded_perl_provider = 1
g.loaded_python_provider = 0
g.loaded_ruby_provider = 1


-- }}}

--" # DEIN {{{

--let s:config_dir = expand('$HOME/.config/nvim')
--let s:dein_repo_path = $HOME . '/.cache/dein'

--" TODO
--" Required:
--set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
--" set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
--set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
--set runtimepath+=$GOPATH/src/github.com/nsf/gocode/nvim


-- Required:
--if dein#load_state($HOME . '/.cache/dein')
--  call dein#begin($HOME . '/.cache/dein') " repo-path
--  call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')
--"   call dein#add('Shougo/vimproc.vim', {'build': 'make'})

--  let s:toml = s:config_dir . '/dein.toml'
--  call dein#load_toml(s:toml, {'lazy' : 0})
--  let s:lazy_toml = s:config_dir . '/dein_lazy.toml'
--  call dein#load_toml(s:lazy_toml, {'lazy' : 1})

--  " Required:
--  call dein#end()
--  call dein#save_state()
--endif

require 'plugins'

-- Required: no required in neovim
-- cmd "filetype plugin indent on" --filetype plugin indent on
-- cmd "syntax enable" --syntax enable

--" If you want to install not installed plugins on startup.
--if dein#check_install()
--  call dein#install()
--endif

-- }}} DEIN


-- # VIM OPTIONS {{{
-- ## INDENT {{{
bo.tabstop = 2
bo.softtabstop = 2
bo.shiftwidth = 2
bo.expandtab = true --set expandtab
bo.autoindent = true --set autoindent
bo.smartindent = true --set smartindent
o.smarttab = true --set smarttab
-- }}} INDENT

-- ## FOLD {{{
cmd "set foldcolumn=1" --set foldcolumn=1
opt.foldlevel = 99 -- cmd "set foldlevel=99" --set foldlevel=99
opt.foldmethod = 'marker' -- cmd "set foldmethod=marker" --set foldmethod=marker
--"set nofoldenable
-- }}} FOLD

-- ## SEARCH {{{
o.hlsearch = true --set hlsearch
o.ignorecase = true --set ignorecase
o.smartcase = true --set smartcase
-- }}}

--" ## BUFFER {{{
opt.autoread = true -- cmd "set autoread" --set autoread
o.hidden = false -- set nohidden -- disable unsaved file.

--"set noswapfile
opt.writebackup = false -- cmd "set nowritebackup" --set nowritebackup
cmd "set fileencodings=utf-8,default,ucs-bom,euc-jp,cp932,shift-jis,latin1"
--set fileencodings=utf-8,default,ucs-bom,euc-jp,cp932,shift-jis,latin1

--if g:is_windows
--  set directory=c:/tmp/swap,c:/temp/swap
--  set backupdir=c:/tmp/swap,c:/temp/swap
--  set undodir=c:/tmp/undo,c:/temp/undo
--else
cmd "set directory=~/.cache/vim/swap" --  set directory=~/.cache/vim/swap
cmd "set undofile undodir=~/.cache/vim/undo" --  set undofile undodir=~/.cache/vim/undo
--endif
-- }}} BUFFER


-- ## VIEW {{{
-- ### color {{{
--if (has("termguicolors"))
o.termguicolors = true --  set termguicolors
--  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--endif
-- }}} color

opt.cmdheight = 3 --cmd "set cmdheight=3" --set cmdheight=3
wo.cursorline = false -- cmd "set nocursorline" --set nocursorline
opt.laststatus = 2 -- cmd "set laststatus=2" --set laststatus=2
opt.cursorcolumn = false -- cmd "set nocursorcolumn"
wo.relativenumber = false -- cmd "set norelativenumber"
wo.signcolumn = 'yes'

o.list = true -- cmd "set list" --set list -- show invisible chars
cmd "set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%"
--set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
-- o.listchars = {
--   tab = '»-',
--   trail = '-',
--   extends = '»',
--   precedes = '«',
--   nbsp = '%',
-- }

wo.number = true --set number  -- show line-number

o.scrolloff = 5 --set scrolloff=5
opt.showcmd = true -- cmd "set showcmd" --set showcmd

--"set textwidth=0 "NOTE: auto by-return
opt.wrap = true -- cmd "set wrap" --set wrap
opt.showtabline = 2 -- cmd "set showtabline=2" --set showtabline=2
opt.display = 'lastline' -- cmd "set display=lastline" --set display=lastline "NOTE: no-@ in long line
cmd "set fillchars=stl:\\ ,stlnc:\\ ,vert:\\|,fold:-,diff:-" -- set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
cmd "let g:vim_indent_cont = 0" --let g:vim_indent_cont = 0


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


--let g:markdown_fenced_languages = [
--\ 'cpp',
--\ 'haskell',
--\ 'ninja',
--\ 'python',
--\ 'sh',
--\ 'css',
--\ 'html',
--\ 'javascript',
--\ ]
--"\ 'fortran',
--"\ 'json=javascript',
--"\ 'lua',
--"\ 'ruby',
--"\ 'verilog',
--"\ 'xml',
cmd [[ let g:markdown_fenced_languages = [
  \ 'cpp',
  \ 'haskell',
  \ 'ninja',
  \ 'python',
  \ 'sh',
  \ 'css',
  \ 'html',
  \ 'javascript',
  \ ]
]]

-- }}} VIEW


-- ## INPUT {{{
cmd "set backspace=indent,eol,start" --set backspace=indent,eol,start
opt.clipboard:append({ "unnamedplus" }) --set clipboard=unnamed
--if has('autoselect')
--  set clipboard+=autoselect
--elseif has('unnamedplus') "CAUTION: need xclip
--  set clipboard+=unnamedplus
--else
--  set clipboard+=unnamedplus
--endif
--set clipboard+=unnamedplus
-- if os.execute('uname -a | grep microsoft') ~= '' then
--   cmd('augroup wsl_clip')
--   cmd('autocmd!')
--   cmd("autocmd TextYankPost * :call system('clip.exe', @\")")
--   cmd('augroup END')
-- end

opt.virtualedit:append({ "block" }) --set virtualedit& virtualedit+=block
-- }}} INPUT

-- ## COMMAND {{{
opt.wildmenu = true --cmd "set wildmenu" --set wildmenu  -- complete in the commandline mode.
opt.wildmode = { "longest", "full" } --set wildmode=longest:full,full
opt.wildignore = { '*.o', '*.a', '*.pyc', '__pycache__', 'node_modules' }
o.history = 2000 -- cmd "set history=2000" --set history=2000
-- cmd "set nostartofline" --set nostartofline
opt.startofline = false
--}}} COMMAND

--}}} VIM OPTIONS


-- SET FILETYPE {{{
--" autocmd myautocmd BufNewFile,BufRead *.{go} set noexpandtab
--autocmd myautocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
--autocmd myautocmd BufNewFile,BufRead *.{pug,tag} set filetype=pug
--autocmd myautocmd BufNewFile,BufRead *.{py} set filetype=python tabstop=4 softtabstop=4 shiftwidth=4
--autocmd myautocmd BufNewFile,BufRead *.{toml} set filetype=toml
--"autocmd myautocmd BufNewFile,BufRead *.vue setlocal filetype=vue.html.typescript.javascript.css
--autocmd myautocmd BufNewFile,BufRead *.vue setlocal filetype=vue
--autocmd myautocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
--autocmd myautocmd BufNewFile,BufRead *.{scad} set filetype=scad
--autocmd myautocmd BufNewFile,BufRead *.template.yaml setlocal filetype=cloudformation.yaml
--set ft=markdown
-- }}}

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
-- vim.api.nvim_create_autocmd({'BufWritePost'})

-- OTHERS {{{
--" no scrach(preview)
opt.title = true -- cmd "set title"  --set title
opt.mouse = 'a' -- cmd "set mouse=a" --set mouse=a
-- }}} OTHERS

o.synmaxcol = 200

o.updatetime = 300 -- any [msec] until creating the swap file
o.timeout = true -- set timeout -- for mappings
o.timeoutlen = 1000 -- set timeoutlen=1000 -- default value
o.ttimeout = true -- set ttimeout -- for key codes
o.ttimeoutlen = 10 -- set ttimeoutlen=10 -- unnoticeable small value

-- ### complete {{{
-- opt.completeopt = "menu,menuone,noselect"
-- cmd "set completeopt-=preview" --set completeopt-=preview
-- }}} complet
-- opt.completeopt = ""
-- opt.completeopt = "preview"
-- opt.completeopt = "menuone,noinsert,noselect"
-- * menuone: display menu at one
-- * noinsert: disable insert with displaying menu
cmd "set completeopt-=preview"
opt.shortmess:append('c') --cmd "set shortmess+=c"

--local cmp = require"cmp"
--cmp.setup({
--  snippet = {
--    expand = function(args)
--      vim.fn["vsnip#anonymous"](args.body)
--    end,
--  },
--  mapping = {
--    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--    ["<C-f>"] = cmp.mapping.scroll_docs(4),
--    ["<C-Space>"] = cmp.mapping.complete(),
--    ["<C-e>"] = cmp.mapping.close(),
--    ["<CR>"] = cmp.mapping.confirm({ select = true }),
--  },
--  sources = cmp.config.sources({
--    { name = "nvim_lsp" },
--    { name = "vsnip" },
--  }, {
--    { name = "buffer" },
--  })
--})

o.showmatch = true
o.matchtime = 1
cmd "set matchpairs& matchpairs+=<:>" --  set nocompatible

g.mapleader = ","

vim.cmd [[ inoremap <silent> jj <ESC>]]

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

-- Restore cursor location when file is opened
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*' },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- insert ',' with space.
vim.api.nvim_set_keymap('i', ',', ',<Space>', { noremap = true, silent = true })
