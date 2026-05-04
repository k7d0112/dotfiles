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

# ------------------------------
# Neovim / LazyVim setup
# ------------------------------

# Neovim が未インストールの場合のみインストール
if ! command -v nvim &> /dev/null; then
  echo "Installing Neovim..."
  brew install neovim
fi

# LazyVim で利用する依存ツールを未インストールの場合のみインストール
if ! command -v rg &> /dev/null; then
  echo "Installing ripgrep..."
  brew install ripgrep
fi

if ! command -v fd &> /dev/null; then
  echo "Installing fd..."
  brew install fd
fi

if ! command -v fzf &> /dev/null; then
  echo "Installing fzf..."
  brew install fzf
fi

if ! command -v lazygit &> /dev/null; then
  echo "Installing lazygit..."
  brew install lazygit
fi

if ! command -v tree-sitter &> /dev/null; then
  echo "Installing tree-sitter-cli..."
  brew install tree-sitter-cli
fi

# 設定ディレクトリのシンボリックリンク作成
echo "Linking Neovim config..."

mkdir -p ~/.config

TARGET="$HOME/.config/nvim"
SOURCE="$DOTFILES_DIR/.config/nvim"

if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  echo "Backing up Neovim config"
  mv "$TARGET" "$TARGET.backup"
fi

ln -snf "$SOURCE" "$TARGET"

echo "== done =="
```
