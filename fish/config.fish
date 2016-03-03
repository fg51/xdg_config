set -gx PATH $HOME/.bin $PATH

set -gx EDITOR vim
set -gx SUDO_EDITOR vim

set -gx CPPUTEST_HOME $HOME/.ghq_data/github.com/cpputest/cpputest

alias image sxiv
alias paraview /opt/paraview/bin/paraview


# fix java for xmonad wmname
set -gx wmname LG3D

# fix zip for mojibake
set -gx ZIPINFOOPT -OCP932
set -gx UNZIPOPT -OCP932


#
# XDG
#
set -gx XDG_CONFIG_DIR $HOME/.config
set -gx XDG_DATA_DIR $HOME/.local/sharconfig


#
# TODO: as eval "$(anyenv init -)"
#
set -gx ANYENV_ROOT $HOME/.anyenv


#
# as eval "$(pyenv init -)"
#
set -gx PYENV_ROOT $ANYENV_ROOT/envs/pyenv
set -gx PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
#pyenv rehash >/dev/null ^&1

eval (pyenv init fish)
eval (pyenv virtualenv-init fish)
#. (pyenv init fish)
#. (pyenv virtualenv-init fish)


#
# GO
#
#set -gx GOPATH $HOME/.go/project
#set -gx GOPATH $HOME/.go/third_party $GOPATH
#set -gx GOPATH "$HOME/.go/third_party" "$HOME/.go/project"
set -gx GOPATH $HOME/.go/third_party

set -gx PATH $HOME/.go/third_party/bin $HOME/.go/project/bin $PATH

#
# HASKELL
#
# set -gx PATH $HOME/.cabal/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

#
# FUNCTIONS
#
function _p --description 'Peco wrapper'
    peco | read LINE
    eval $argv[1] $LINE
end

function pecod
    find .| _p cd
end

function pecoghq
    ghq list --full-path| _p cd
end
