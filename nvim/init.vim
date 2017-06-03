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
let g:is_nvim = has('nvim')
let g:is_windows = has('win32') || has('win64')
let g:is_unix = has('unix')
let g:is_gui = has('gui_running')
let g:is_terminal = !g:is_gui
let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8')
    \ && !(exists('g:discard_unicode') && g:discard_unicode != 0)
" }}} conditions

" must be set with multibyte strings
scriptencoding utf-8
" }}} INITIALIZE


" # DEIN {{{
"
let s:config_dir = expand('$HOME/.config/nvim')
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = g:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:dein_cache_path = expand('~/.cache/dein')

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
"let &runtimepath = g:dein_dir . '/repos/github.com/Shougo/dein.vim,' . $runtimepath

" Required:
if dein#load_state(s:dein_cache_path)
    call dein#begin(s:dein_cache_path)

    " Let dein manage dein
    " Required:
    call dein#add('Shougo/dein.vim')

    let s:toml_file = s:config_dir . '/dein.toml'
    call dein#load_toml(s:toml_file, {'lazy' : 0})

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
set fileencodings=utf-8,default,ucs-bom,latin1

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
if g:is_nvim
  let $NVIM_TUI_ENABLE_TRU_COLOR=1 "NOTE: old command
  "set termguicolors
endif
if g:is_terminal
  set t_Co=256
endif

set cmdheight=3 "set cmdheight=2
set nocursorline
set laststatus=2
"set statusline=%n\%y
"set statusline+=[%{(&fenc!=''?&fenc:&enc)}]
"set statusline+=[%{Getff()}]
"set statusline+=%m%r\%F%=[%l/%L]
"
"function! Getff()
"  if &ff == 'unix'
"    return 'LF'
"  elseif &ff == 'dos'
"    return 'CR+LF'
"  elseif &ff == 'mac'
"    return 'CR'
"  else
"    return '?'
"  endif
"endfunction

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

set completeopt-=preview    " what is this ???

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
"autocmd BufNewFile,BufRead *.{py} set filetype=python
autocmd myautocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd myautocmd BufNewFile,BufRead *.{toml} set filetype=toml
autocmd myautocmd BufNewFile,BufRead *.{pug,tag} set filetype=pug
autocmd myautocmd BufNewFile,BufRead *.{js,ts,pug} set tabstop=2 softtabstop=2 shiftwidth=2
autocmd myautocmd BufNewFile,BufRead *.{c,cpp,hs} set tabstop=2 softtabstop=2 shiftwidth=2
set ft=markdown
" }}}


" for HASKELL
"
"" let g:haskellmode_completion_ghc = 0
"" autocmd myautocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
"" let g:ycm_semantic_triggers = {'haskell':['.']}



" OTHERS {{{


"" enable python3
""
"let g:python3_host_prog = '~/.anyenv/envs/pyenv/shims/python'



set completeopt=menuone
" no scrach(preview)
set title
set mouse=a


" }}} OTHERS


set guifont=Ricty\ Diminished\ 13

" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)

"let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python2)/bin/python"); echo -n $(which python2)')
"let g:python3_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python3)/bin/python"); echo -n $(which python3)')
