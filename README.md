# dotfiles

このリポジトリは、シェル・Git・エディタなどの設定ファイルをGitで一元管理し、
どのマシンでも同一の開発環境を再現するためのものです。

---

## 参考記事
https://qiita.com/yutkat/items/c6c7584d9795799ee164

---

## セットアップ手順（新規環境で下記のコマンドをターミナルで実行）

```bash
git clone git@github.com:k7d0112/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
chmod +x install.sh
./install.sh
```
---

## .configディレクトリ管理

このリポジトリでは、アプリケーションごとの設定ファイル（.config配下）も管理対象としています。

### 方針

- `~/.config` 配下の設定は直接編集しない
- `~/workspace/dotfiles/.config` で一元管理する
- `install.sh` によりシンボリックリンクを作成する

### ディレクトリ構成

- 実体ディレクトリ  
  `~/workspace/dotfiles/.config/`

- 反映先  
  `~/.config/`

### セットアップ時の動作

`install.sh` 実行時に以下が行われます：

- `~/.config` が存在しない場合は作成
- 各設定ファイルをシンボリックリンクで反映

### 今後のconfig追加ルール

新しい設定ファイルを追加する場合は、以下の手順で管理します：

1. 設定ファイルをdotfiles配下に移動する  
2. `install.sh` にシンボリックリンク作成処理を追加する  
3. 必要に応じてREADME.mdを更新する  

この運用により、`git clone → ./install.sh` のみで環境を再現できる状態を維持します。

---

## Starship設定

このリポジトリでは、プロンプトツールであるStarshipの設定を管理しています。

### 構成

- 実体ファイル  
  `~/workspace/dotfiles/.config/starship.toml`

- シンボリックリンク  
  `~/.config/starship.toml`

### セットアップ時の動作

`install.sh` 実行時に以下が自動で行われます：

- Homebrew経由でstarshipをインストール（未導入の場合）
- 設定ファイルのシンボリックリンク作成

---

## WezTerm設定

このリポジトリでは、ターミナルエミュレータであるWezTermの設定も管理しています。

### 構成

- 実体ファイル  
  `~/workspace/dotfiles/.config/wezterm/wezterm.lua`

- シンボリックリンク  
  `~/.config/wezterm/wezterm.lua`

### セットアップ時の動作

`install.sh` 実行時に以下が自動で行われます：

- `~/.config/wezterm` ディレクトリの作成（存在しない場合）
- 設定ファイルのシンボリックリンク作成

### 補足

- WezTermは起動時に `~/.config/wezterm/wezterm.lua` を読み込みます
- 設定変更後はWezTermの再起動、または設定のリロードが必要です

---

## Neovim / LazyVim設定

このリポジトリでは、Neovimの設定をLazyVimベースで管理しています。

### 構成

- 実体ディレクトリ  
  `~/workspace/dotfiles/.config/nvim/`

- シンボリックリンク  
  `~/.config/nvim`

### セットアップ時の動作

`install.sh` 実行時に以下が自動で行われます：

- Homebrew経由でNeovimをインストール（未導入の場合）
- LazyVimで利用する依存ツールをインストール（未導入の場合）
  - `ripgrep`
  - `fd`
  - `fzf`
  - `lazygit`
  - `tree-sitter-cli`
- `~/.config` ディレクトリの作成（存在しない場合）
- Neovim設定ディレクトリのシンボリックリンク作成

### 補足

- Neovimは起動時に `~/.config/nvim/init.lua` を読み込みます
- LazyVimのプラグイン本体は `~/.local/share/nvim` 配下にインストールされます
- `lazy-lock.json` はプラグインのバージョン固定に使うため、Git管理対象とします
- 初回起動後はNeovim内で `:Lazy sync`、`:Mason`、`:LazyHealth` を実行して状態を確認します

---

## install.sh の拡張方法

### ホームディレクトリのドットファイルを追加する場合

`install.sh` の `FILES` 配列に追記するだけで、自動でシンボリックリンクが作成されます。

```bash
FILES=(
  ".zshrc"
  ".tmux.conf"  # 追加例
)
```

追加する前に、対象ファイルを `~/workspace/dotfiles/` 配下に配置してください。

### `.config` 配下の設定を追加する場合

既存の starship / wezterm / nvim のブロックを参考に、以下のパターンで追記します。

```bash
# ① ツールのインストール確認（必要な場合）
if ! command -v <tool> &> /dev/null; then
  brew install <tool>
fi

# ② シンボリックリンク作成
TARGET="$HOME/.config/<tool>"
SOURCE="$DOTFILES_DIR/.config/<tool>"

if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  echo "Backing up <tool> config"
  mv "$TARGET" "$BACKUP_DIR/<tool>.$(date +%Y%m%d%H%M%S)"
fi

ln -snf "$SOURCE" "$TARGET"
```

追加する前に、設定ファイルを `~/workspace/dotfiles/.config/<tool>/` 配下に配置してください。

### バックアップについて

`install.sh` 実行時に既存ファイルが存在する場合、`~/.backup/` 配下にタイムスタンプ付きで保存されます。

```
~/.backup/.zshrc.20260505123456
~/.backup/starship.toml.20260505123456
```

実行のたびに上書きされず履歴として蓄積されるため、必要に応じて手動で削除してください。

---

## 運用方法

```bash
cd ~/workspace/dotfiles
git add .
git commit -m "update config"
git push
```
