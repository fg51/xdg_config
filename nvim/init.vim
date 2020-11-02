if 0 | endif

" # INITIALIZE {{{
"
if &compatible
  set nocompatible
endif

augroup myautocmd
  autocmd!
augroup END


" ## conditions {{{
"
let g:is_windows = has('win32') || has('win64')
let g:is_gui = has('gui_running')
let g:is_terminal = !g:is_gui
let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8')
    \ && !(exists('g:discard_unicode') && g:discard_unicode != 0)
" }}} conditions

" must be set with multibyte strings
scriptencoding utf-8
" }}} INITIALIZE


" {{{ python3, python2
let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python2')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python3')
" }}}

" # DEIN {{{
"
let s:config_dir = expand('$HOME/.config/nvim')
let s:dein_repo_path = $HOME . '.cache/dein'


" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
" set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
set runtimepath+=$GOPATH/src/github.com/nsf/gocode/nvim


" Required:
if dein#load_state(s:dein_repo_path)
  let g:dein#cache_directory = $HOME . '/.cache/nvim/dein/cache'
  call dein#begin($HOME . '/.cache/dein') " repo-path
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})

  let s:toml = s:config_dir . '/dein.toml'
  call dein#load_toml(s:toml, {'lazy' : 0})
  let s:lazy_toml = s:config_dir . '/dein_lazy.toml'
  call dein#load_toml(s:lazy_toml, {'lazy' : 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" }}} DEIN


" Required:
filetype plugin indent on
syntax enable


" # VIM OPTIONS {{{
" ## INDENT {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab
" }}} INDENT

" ## FOLD {{{
set foldcolumn=1
set foldlevel=99
set foldmethod=marker
"set nofoldenable
" }}} FOLD

" ## SEARCH {{{
set hlsearch
nohlsearch
set ignorecase
set smartcase
" }}}

" ## BUFFER {{{
set autoread
set nohidden

"set noswapfile
set nowritebackup
set fileencodings=utf-8,default,ucs-bom,cp932,shift-jis,latin1

if g:is_windows
  set directory=c:/tmp/swap,c:/temp/swap
  set backupdir=c:/tmp/swap,c:/temp/swap
  set undodir=c:/tmp/undo,c:/temp/undo
else
  set directory=~/.cache/vim/swap
  set undofile undodir=~/.cache/vim/undo
endif
" }}} BUFFER


" ## VIEW {{{
" ### color {{{
if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" }}} color

set cmdheight=3 "set cmdheight=2
set nocursorline
set laststatus=2

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

set number

set scrolloff=5
set showcmd

"set textwidth=0 "NOTE: auto by-return
set title
set wrap
set showtabline=2
set display=lastline "NOTE: no-@ in long line
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
let g:vim_indent_cont = 0


" NOTE: simple statuline
"set statusline=%f%M%R%H%W%q%{&ff=='unix'?'':',['.&ff.']'}%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}%{GetQuickFixCount()==0?'':'\ [!'.GetQuickFixCount().']'}%=%(\|%3p%%%)
"set statusline=%f%M%R%H%W%q
"set statusline+=%{&ff=='unix'?'':',['.&ff.']'}
"set statusline+=%{&fenc=='utf-8'\|\|&fenc==''?'':',['.&fenc.']'}
"set statusline+=%{GetQuickFixCount()==0?'':'\ [!'.GetQuickFixCount().']'}
"set statusline+=%=%(\|%3p%%%)
"function! GetQuickFixCount() abort
"  return len(filter(getqflist(), 'v:val.valid != 0'))
"endfunction

" ### complete {{{
set completeopt-=preview
" }}} complet

let g:markdown_fenced_languages = [
\ 'cpp',
\ 'haskell',
\ 'ninja',
\ 'python',
\ 'sh',
\ 'css',
\ 'html',
\ 'javascript',
\ ]
"\ 'fortran',
"\ 'json=javascript',
"\ 'lua',
"\ 'ruby',
"\ 'verilog',
"\ 'xml',

" }}} VIEW


" ## INPUT {{{
set backspace=indent,eol,start
set clipboard=unnamed
if has('autoselect')
  set clipboard+=autoselect
elseif has('unnamedplus') "CAUTION: need xclip
  set clipboard+=unnamedplus
else
  set clipboard+=unnamedplus
endif
set clipboard+=unnamedplus

set virtualedit& virtualedit+=block
" }}} INPUT

" ## COMMAND {{{
set wildmenu
set wildmode=longest:full,full
set history=2000
set nostartofline
"}}} COMMAND

"}}} VIM OPTIONS




" SET FILETYPE {{{
" autocmd myautocmd BufNewFile,BufRead *.{go} set noexpandtab
autocmd myautocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd myautocmd BufNewFile,BufRead *.{pug,tag} set filetype=pug
autocmd myautocmd BufNewFile,BufRead *.{py} set filetype=python tabstop=4 softtabstop=4 shiftwidth=4
autocmd myautocmd BufNewFile,BufRead *.{toml} set filetype=toml
"autocmd myautocmd BufNewFile,BufRead *.vue setlocal filetype=vue.html.typescript.javascript.css
autocmd myautocmd BufNewFile,BufRead *.vue setlocal filetype=vue
autocmd myautocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd myautocmd BufNewFile,BufRead *.{scad} set filetype=scad
autocmd myautocmd BufNewFile,BufRead *.template.yaml setlocal filetype=cloudformation.yaml
" autocmd VimEnter * imap <Nul> <Nop>
" autocmd VimEnter * map <Nul> <C-Space>
" autocmd VimEnter * map! <Nul> <C-Space>
set ft=markdown
" }}}


" OTHERS {{{
" no scrach(preview)
set title
set mouse=a
" }}} OTHERS
