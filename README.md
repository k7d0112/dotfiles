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

### 今後のconfig追加ルール

新しい設定ファイルを追加する場合は、以下の手順で管理します：

1. 設定ファイルをdotfiles配下に移動する  
2. `install.sh` にシンボリックリンク作成処理を追加する  
3. 必要に応じてREADME.mdを更新する  

この運用により、`git clone → ./install.sh` のみで環境を再現できる状態を維持します。

---

## 運用方法

```bash
cd ~/workspace/dotfiles
git add .
git commit -m "update config"
git push
```
