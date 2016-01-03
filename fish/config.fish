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
pyenv rehash >/dev/null ^&1

eval (pyenv virtualenv-init fish)
#eval (pyenv virtualenv-init -)

