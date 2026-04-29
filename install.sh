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

echo "== done =="
```
