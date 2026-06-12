# dotfiles

sunouchi の個人用 dotfiles。

## セットアップ（新しい Mac）

### 1. Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Xcode Command Line Tools が未導入なら Homebrew インストーラが自動で入れてくれる。
2 行目の `eval` は今開いているシェルで `brew` を使えるようにするためのもの（次回以降は `.zprofile` が読み込む）。

### 2. dotfiles を配置してパッケージをインストール

```bash
git clone git@github.com:sunouchi/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
brew bundle install
```

CLI ツールに加えて、GUI アプリ（Google Chrome / Claude Desktop / BetterTouchTool / Speedtest / VS Code）も Brewfile の cask で一緒にインストールされる。

### 3. 言語ランタイムをインストール

node / python は mise で管理している（Brewfile には入れない）。

```bash
mise install
```

`.config/mise/config.toml` に定義されたバージョン（node lts / python 3.13）が入る。

### 4. Claude Code をインストール

npm 経由ではなく公式インストーラを使う（公式推奨。自己アップデートが効き、node 環境に依存しない）。

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

## 主な内容

- zsh — `.zshrc`, `.zshrc.custom`, `.zshrc.alias`, `.zprofile`
- vim / nvim — `.vimrc`, `.vimrc.*`
- tmux — `.tmux.conf`
- git — `.gitconfig`, `.gitignore`
- Homebrew — `Brewfile`（CLI ツール + GUI アプリの cask）
- VS Code — `setup-vscode.sh`

言語ランタイム（node / python / ruby 等）は [mise](https://mise.jdx.dev/) で管理。
