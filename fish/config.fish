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
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib

alias image sxiv
alias view_pdf evince
alias paraview /opt/paraview/bin/paraview
alias cmd /mnt/c/Windows/System32/cmd.exe
alias powershell /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
alias explorer /mnt/c/Windows/explorer.exe
alias hx helix
alias ls exa

# alias pdf /mnt/c/Program\ Files\ \(x86\)/Adobe/Acrobat\ Reader\ DC/Reader/AcroRd32.exe
# function x86
#   echo '(x86)'
# end

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
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showupstream 'yes'
# set __fish_git_prompt_color_branch yellow
#
# # Status Chars
# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '↑'
# set __fish_git_prompt_char_upstream_behind '↓'

# function fish_prompt
#     set last_status $status
#     set_color $fish_color_cwd
#     printf '%s' (prompt_pwd)
#     set_color normal
#     printf '%s ' (__fish_git_prompt)
#     set_color normal
# end


# aws
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); aws_completer; end)'


# TODO: as eval "$(anyenv init -)"
#
#set -gx ANYENV_ROOT $HOME/.anyenv
#set -x PATH "$ANYENV_ROOT/bin" $PATH
# anyenv init - fish | source
#status --is-interactive; and source (anyenv init -|psub)
# status --is-interactive; and source (anyenv init - fish |psub)


# as eval "$(pyenv init -)"
#
#set -gx PYENV_ROOT "$ANYENV_ROOT/envs/pyenv"
# set -x PATH "$PYENV_ROOT/shims" $PATH

# if test -d $PYENV_ROOT
#     status --is-interactive; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
# end
# if test -d $PYENV_ROOT
#     status --is-interactive; and source (pyenv init -|psub)
# end
#if test -d $PYENV_ROOT
#    status --is-interactive; and source (pyenv virtualenv-init -|psub)
#end

# set -gx NDENV_ROOT $ANYENV_ROOT/envs/ndenv
# set -gx PATH $ANYENV_ROOT/envs/ndenv/bin $PATH
# set -gx PATH $NDENV_ROOT/shims $PATH

#
# GO
#
#set -gx GOROOT (go env GOROOT)
set -gx GOPATH $HOME/.go
set -gx PATH $HOME/.go/bin $PATH
set -gx GO111MODULE on

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

# linuxbrew
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
set -g PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
set -q MANPATH or set MANPATH ''
set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
set -q INFOPATH or set INFOPATH ''
set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

# zoxide
if command -sq zoxide
    zoxide init fish | source
end

eval (dircolors -c $HOME/.config/dir_colors)

source ~/.asdf/asdf.fish
starship init fish | source
