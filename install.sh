#!/usr/bin/env zsh
set -euo pipefail

DOTFILES="${0:A:h}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

create_symlink() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "Backing up $dest to ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -sfn "$src" "$dest"
  echo "ok symlink $dest"
}

if [[ "${1:-}" == --self-test ]]; then
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  echo src >"$tmp/src"
  mkdir -p "$tmp/home"
  create_symlink "$tmp/src" "$tmp/home/link"
  [[ -L "$tmp/home/link" ]] || { echo "fail: link"; exit 1 }
  echo real >"$tmp/home/real"
  create_symlink "$tmp/src" "$tmp/home/real"
  [[ -f "$tmp/home/real.bak" ]] || { echo "fail: bak"; exit 1 }
  echo "self-test ok"
  exit 0
fi

case "$(uname -s)" in
  Darwin|Linux) ;;
  *) echo "fail: only macOS and Linux are supported"; exit 1 ;;
esac

# ==============================================================================
# Core Symlinks
# ==============================================================================
create_symlink "$DOTFILES/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"

# Config directories (Neovim, Ghostty, etc. inside .config)
if [[ -d "$DOTFILES/.config" ]]; then
  for conf in "$DOTFILES/.config"/*(N); do
    create_symlink "$conf" "$CONFIG_HOME/${conf:t}"
  done
fi

# Ghostty on macOS also reads Application Support.
if [[ "$(uname -s)" == Darwin ]]; then
  if [[ -d "$DOTFILES/.config/ghostty" ]]; then
    create_symlink "$DOTFILES/.config/ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty"
  fi
fi

echo "Done. Core dotfiles successfully symlinked."
