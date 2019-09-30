#
# fisherman
#
#set fisher_home ~/.local/share/fisherman
#set fisher_config ~/.config/fisherman
#source $fisher_home/config.fish


#
# my bin path
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.bin $HOME/.local/bin $PATH
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib

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
# TODO: as eval "$(anyenv init -)"
# anyenv init - fish | source
# set -Ux fish_user_paths $ANYENV_ROOT/bin $fish_user_paths
# status --is-interactive; and source (anyenv init -|psub)
# status --is-interactive; and anyenv init - fish | source
# anyenv init - fish | source
# eval (anyenv init)

# as eval "$(pyenv init -)"
#
set -gx PYENV_ROOT "$ANYENV_ROOT/envs/pyenv"
# set -x PATH "$PYENV_ROOT/shims" "$PYENV_ROOT/bin" $PATH

# if test -d $PYENV_ROOT
#     status --is-interactive; and source (pyenv init -| psub); and source (pyenv virtualenv-init -| psub)
# end

# set -gx NDENV_ROOT $ANYENV_ROOT/envs/ndenv
# set -gx PATH $ANYENV_ROOT/envs/ndenv/bin $PATH
# set -gx PATH $NDENV_ROOT/shims $PATH

#
# GO
# set -gx GOROOT (go env GOROOT)
# set -Ux GOPATH $HOME/.go
# set -Ux PATH $HOME/.go/bin $PATH
set -gx fish_user_paths $HOME/.go/bin $fish_user_paths


# oh-my-fish/plugin-peco
# function fish_user_key_bindings
#     bind \cr 'peco_select_history (commandline -b)'
# end

# fish-peco_select_ghq_reopsitory
# function fish_user_key_bindings
#   bind \cr 'peco_select_history (commandline -b)'
#   bind \c] peco_select_ghq_repository
# end

set -gx GTAGSLABEL pygments

# RUST
# set -gx RUST_ROOT (rustc --print sysroot)/lib
set -gx RUST_ROOT $HOME/.rustup/toolchains/beta-x86_64-unknown-linux-gnu
set -gx CARGO_ROOT $HOME/.cargo
set -gx PATH $CARGO_ROOT/bin $PATH
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH (rustc --print sysroot)/lib
# set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
