set -gx EDITOR vim
set -gx SUDO_EDITOR vim


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
# FUNCTIONS
#
function _p --description 'Peco wrapper'
    peco | read LINE
    eval $argv[1] $LINE
end

function pecod
    find .| _p cd
end

