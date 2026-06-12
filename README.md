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

### 5. macOS の設定を反映

GUI（システム設定）からは設定できない項目を反映する。

```bash
./setup-macos.sh
```

- トラックパッドのポインタ速度を 5 にする（システム設定の最大 3 より速い）。**ログアウト / 再起動後**に有効。
- Finder で隠しファイルを常に表示する（⌘⇧. のトグルだと誤操作で戻るため、明示的に設定）。

## 主な内容

- zsh — `.zshrc`, `.zshrc.custom`, `.zshrc.alias`, `.zprofile`
- vim / nvim — `.vimrc`, `.vimrc.*`
- tmux — `.tmux.conf`
- git — `.gitconfig`, `.gitignore`
- Homebrew — `Brewfile`（CLI ツール + GUI アプリの cask）
- VS Code — `setup-vscode.sh`
- macOS — `setup-macos.sh`（トラックパッド速度 / 隠しファイル表示など defaults 設定）

言語ランタイム（node / python / ruby 等）は [mise](https://mise.jdx.dev/) で管理。
