#
# fisherman
#
#set fisher_home ~/.local/share/fisherman
#set fisher_config ~/.config/fisherman
#source $fisher_home/config.fish


#
# my bin path
#
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.bin $HOME/.local/bin $PATH

alias image sxiv
alias view_pdf evince
alias paraview /opt/paraview/bin/paraview


# EDITOR
#
set -gx EDITOR vim
set -gx SUDO_EDITOR vim


# fix java for xmonad wmname
set -gx wmname LG3D


# fix zip for mojibake
set -gx ZIPINFOOPT -OCP932
set -gx UNZIPOPT -OCP932


# XDG
#
set -gx XDG_CONFIG_DIR $HOME/.config
set -gx XDG_DATA_DIR $HOME/.local/sharconfig


# GIT
#

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
end


# TODO: as eval "$(anyenv init -)"
#
set -gx ANYENV_ROOT $HOME/.anyenv


# as eval "$(pyenv init -)"
#
set -gx PYENV_ROOT $ANYENV_ROOT/envs/pyenv
set -gx PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH

if test -d $PYENV_ROOT
    status --is-interactive; and . (pyenv init -| psub); and . (pyenv virtualenv-init -| psub)
end


#
# GO
#
set -gx GOPATH $HOME/.go/third_party
set -gx PATH $HOME/.go/third_party/bin $HOME/.go/project/bin $PATH


# oh-my-fish/plugin-peco
# function fish_user_key_bindings
#     bind \cr 'peco_select_history (commandline -b)'
# end

# fish-peco_select_ghq_reopsitory
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \c] peco_select_ghq_repository
end
