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
# Starship setup
# ------------------------------

# Homebrew が使えるかチェック
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

# starship が未インストールの場合のみインストール
if ! command -v starship &> /dev/null; then
  echo "Installing starship..."
  brew install starship
fi

# 設定ファイルのシンボリックリンク作成
echo "Linking starship config..."
mkdir -p ~/.config
ln -sf ~/workspace/dotfiles/.config/starship.toml ~/.config/starship.toml

echo "== done =="
```
