#!/bin/bash

link_dotfile() {
  SRC=$1
  DST=$2
  if [ -L "$DST" ] || [ -e "$DST" ]; then
    echo "Removing existing $DST"
    rm -rf "$DST"
  fi
  ln -s "$SRC" "$DST"
  echo "Symlink created: $DST -> $SRC"
}

link_dotfile ~/git_repo/Elwafi_dotfiles/swaync ~/.config/swaync
link_dotfile ~/git_repo/Elwafi_dotfiles/kitty ~/.config/kitty
link_dotfile ~/git_repo/Elwafi_dotfiles/wofi ~/.config/wofi
link_dotfile ~/git_repo/Elwafi_dotfiles/waybar ~/.config/waybar
link_dotfile ~/git_repo/Elwafi_dotfiles/hypr ~/.config/hypr
link_dotfile ~/git_repo/Elwafi_dotfiles/starship.toml ~/.config/starship.toml