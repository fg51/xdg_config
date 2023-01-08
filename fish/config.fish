if status is-interactive
  # Commands to run in interactive sessions can go here

# {{{ alias
  alias image sxiv
  alias view_pdf evince
  alias paraview /opt/paraview/bin/paraview
  alias powershell /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
  alias explorer /mnt/c/Windows/explorer.exe
  alias hx helix
  alias ls exa
  alias la 'exa -la'
# }}}

  eval (dircolors -c $HOME/.config/dir_colors)

  # zoxide
  if command -sq zoxide
      zoxide init fish | source
  end

  starship init fish | source
end

source /opt/asdf-vm/asdf.fish

# {{{ my bin path
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.bin
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib
# }}}


# {{{ EDITOR
set -gx EDITOR vim
set -gx SUDO_EDITOR vim
# }}}

# fix java for xmonad wmname
set -gx wmname LG3D


# fix zip for mojibake
set -gx ZIPINFOOPT -OCP932
set -gx UNZIPOPT -OCP932


# XDG
set -gx XDG_CONFIG_DIR $HOME/.config
set -gx XDG_DATA_DIR $HOME/.local/sharconfig

set -gx GTAGSLABEL pygments

# {{{ GIT

# fish git prompt
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_color_branch yellow

# Status Chars
#set __fish_git_prompt_char_dirtystate '⚡'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_stashstate '↩'
#set __fish_git_prompt_char_upstream_ahead '↑'
#set __fish_git_prompt_char_upstream_behind '↓'

#function fish_prompt
#    set last_status $status
#    set_color $fish_color_cwd
#    printf '%s' (prompt_pwd)
#    set_color normal
#    printf '%s ' (__fish_git_prompt)
#    set_color normal
#end
# }}}

function git_enable_gpg
  if test -z "$argv[1]"
    echo "please provide a GPG key ID"
    echo "git enable gpg {GPG_ID}"
    return 1
  end

  echo "checking the GPG key ID..."
  gpg --list-keys $argv[1]

  if test $status -ne 0
    echo "Invalid GPG key ID"
    return 1
  end

  echo "Enable GPG signing..."

  git config user.signingKey $argv[1]

  git config commit.gpgsign true
end


# {{{ aws
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); aws_completer; end)'
# }}}

# {{{ TODO: as eval "$(anyenv init -)"

#set -gx ANYENV_ROOT $HOME/.anyenv
#set -x PATH "$ANYENV_ROOT/bin" $PATH
#status --is-interactive; and source (anyenv init -|psub)

#set -gx PYENV_ROOT "$ANYENV_ROOT/envs/pyenv"
#set -x PATH "$PYENV_ROOT/shims" "$PYENV_ROOT/bin" $PATH

# if test -d $PYENV_ROOT
#   status --is-interactive; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
# end
#if test -d $PYENV_ROOT/plugins/pyenv-virtualenv
#  status --is-interactive; and source (pyenv virtualenv-init -|psub)
#end

#set -gx NDENV_ROOT $ANYENV_ROOT/envs/ndenv
# set -gx PATH $ANYENV_ROOT/envs/ndenv/bin $PATH
# set -gx PATH $NDENV_ROOT/shims $PATH
# }}}

# {{{ GO
# set -gx GOROOT (go env GOROOT)
# set -gx GOPATH $HOME/.go
# set -gx PATH $HOME/.go/bin $PATH
# set -gx GO111MODULE on
# }}}


# {{{ RUST
set -gx RUST_ROOT $HOME/.rustup/toolchains/beta-x86_64-unknown-linux-gnu
# set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH (~/.cargo/rustc --print sysroot)/lib
if test -x "~/.cargo/rustc"
  set RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
  if test -d $RUST_SRC_PATH
    export RUST_SRC_PATH
  end
end

# # set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
set -gx CARGO_ROOT $HOME/.cargo
fish_add_path $CARGO_ROOT/bin
# }}}

# {{{ linuxbrew
# set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
# set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
# set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
# set -g PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
# set -q MANPATH or set MANPATH ''
# set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
# set -q INFOPATH or set INFOPATH ''
# set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
# }}}

set -U FZF_LEGACY_KEYBINDINGS 0
