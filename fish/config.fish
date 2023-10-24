set fish_greeting ""

if status is-interactive
  # Commands to run in interactive sessions can go here
  alias image sxiv
  alias view_pdf evince
  alias paraview /opt/paraview/bin/paraview
  alias powershell /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
  alias explorer /mnt/c/Windows/explorer.exe
  alias hx helix
  alias ls exa
  alias la 'exa -la'

  eval (dircolors -c $HOME/.config/dir_colors)

  # zoxide
  if command -sq zoxide
      zoxide init fish | source
  end

  starship init fish | source
end

#source ~/.asdf/asdf.fish
~/.local/share/rtx/bin/rtx activate fish | source

# my bin path
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.bin
fish_add_path $HOME/.local/share/azure-functions-cli
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib


# EDITOR
set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim


# fix java for xmonad wmname
set -gx wmname LG3D


# fix zip for mojibake
set -gx ZIPINFOOPT -OCP932
set -gx UNZIPOPT -OCP932


# XDG
#
set -gx XDG_CONFIG_DIR $HOME/.config
set -gx XDG_DATA_DIR $HOME/.local/sharconfig

set -gx GTAGSLABEL pygments

# RUST
# set -gx RUST_ROOT (rustc --print sysroot)/lib
set -gx RUST_ROOT $HOME/.rustup/toolchains/beta-x86_64-unknown-linux-gnu
set -gx CARGO_ROOT $HOME/.cargo
fish_add_path $CARGO_ROOT/bin
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH (rustc --print sysroot)/lib
# set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src

# fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# switch (uname)
#   # case Darwin
#   #   source (dirname (status --current-filename))/config-osx.fish
#   case Linux
#     source (dirname (status --current-filename))/config-linux.fish
#   case '*'
#     source (dirname (status --current-filename))/config-windows.fish
# end

# pnpm
set -gx PNPM_HOME "/home/kflange/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
