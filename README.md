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

## 運用方法

```bash
cd ~/workspace/dotfiles
git add .
git commit -m "update config"
git push
```
