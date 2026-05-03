---

# ② install.sh（これだけコピペ）

```bash
#!/bin/bash

set -e

DOTFILES_DIR="$HOME/workspace/dotfiles"

echo "== dotfiles setup start =="

FILES=(
  ".zshrc"
  ".gitconfig"
  ".vimrc"
  ".tmux.conf"
)

for file in "${FILES[@]}"; do
  TARGET="$HOME/$file"
  SOURCE="$DOTFILES_DIR/$file"

  if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
    echo "Backing up $file"
    mv "$TARGET" "$TARGET.backup"
  fi

  echo "Linking $file"
  ln -sf "$SOURCE" "$TARGET"
done

if [ -f "$HOME/.zshrc" ]; then
  echo "Applying zsh config"
  source "$HOME/.zshrc"
fi

# ------------------------------
# Prerequisite check
# ------------------------------

if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

# ------------------------------
# Starship setup
# ------------------------------

# starship が未インストールの場合のみインストール
if ! command -v starship &> /dev/null; then
  echo "Installing starship..."
  brew install starship
fi

# 設定ファイルのシンボリックリンク作成
echo "Linking starship config..."

mkdir -p ~/.config

TARGET="$HOME/.config/starship.toml"
SOURCE="$DOTFILES_DIR/.config/starship.toml"

if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  echo "Backing up starship config"
  mv "$TARGET" "$TARGET.backup"
fi

ln -snf "$SOURCE" "$TARGET"

# ------------------------------
# WezTerm setup
# ------------------------------

# WezTerm が未インストールの場合のみインストール
if ! command -v wezterm &> /dev/null; then
  echo "Installing WezTerm nightly..."
  brew install --cask wezterm@nightly
fi

# 設定ファイルのシンボリックリンク作成
echo "Linking WezTerm config..."

mkdir -p ~/.config

TARGET="$HOME/.config/wezterm"
SOURCE="$DOTFILES_DIR/.config/wezterm"

if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  echo "Backing up wezterm config"
  mv "$TARGET" "$TARGET.backup"
fi

ln -snf "$SOURCE" "$TARGET"

echo "== done =="
```
