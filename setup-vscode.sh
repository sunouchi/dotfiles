#!/usr/bin/env bash
#
# setup-vscode.sh — Visual Studio Code の環境を別マシンで一発再現するスクリプト。
#
# このファイル 1 つだけで、拡張機能と settings.json を丸ごと復元できる。
# データ（拡張機能リスト / 設定値）はこのスクリプト内に埋め込んである。
#
# 使い方:
#   ./setup-vscode.sh           拡張機能をインストールし、settings.json を反映する
#   ./setup-vscode.sh --export  いまのマシンの状態をこのファイルへ書き戻す（メンテ用）
#
# メモ:
#   - keybindings / snippets は現状空のため未管理。必要になったら DATA ブロックに足す。
#   - 既存の settings.json は上書き前にタイムスタンプ付きでバックアップする。
#
set -euo pipefail

USER_DIR="$HOME/Library/Application Support/Code/User"

# ===== VSCODE DATA (auto-generated; refresh with: ./setup-vscode.sh --export) =====
EXTENSIONS=(
  almenon.arepl
  anthropic.claude-code
  astro-build.astro-vscode
  batisteo.vscode-django
  bierner.markdown-mermaid
  bmewburn.vscode-intelephense-client
  chrmarti.regex
  codezombiech.gitignore
  donjayamanne.githistory
  donjayamanne.python-environment-manager
  donjayamanne.python-extension-pack
  eamodio.gitlens
  emilast.logfilehighlighter
  esbenp.prettier-vscode
  formulahendry.auto-rename-tag
  gera2ld.markmap-vscode
  github.vscode-pull-request-github
  humao.rest-client
  ibm.output-colorizer
  ikappas.phpcs
  ionutvmi.path-autocomplete
  junstyle.php-cs-fixer
  kevinrose.vsc-python-indent
  mechatroner.rainbow-csv
  mrmlnc.vscode-duplicate
  ms-azuretools.vscode-containers
  ms-ceintl.vscode-language-pack-ja
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  ms-toolsai.jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  ms-vscode-remote.remote-containers
  neilbrayfield.php-docblocker
  njpwerner.autodocstring
  openai.chatgpt
  reddevil.pythondoc
  ritwickdey.liveserver
  rogalmic.bash-debug
  ryu1kn.partial-diff
  shan.code-settings-sync
  shardulm94.trailing-spaces
  silvenon.mdx
  sophisticode.php-formatter
  tomoki1207.pdf
  tushortz.python-extended-snippets
  unifiedjs.vscode-mdx
  visualstudioexptteam.intellicode-api-usage-examples
  visualstudioexptteam.vscodeintellicode
  vscode-icons-team.vscode-icons
  vscodevim.vim
  wayou.vscode-todo-highlight
  wholroyd.jinja
  xdebug.php-debug
  xyc.vscode-mdx-preview
)
read -r -d '' SETTINGS_JSON <<'SETTINGS_EOF' || true
{
    "editor.wordWrap": "on",
    "workbench.iconTheme": "vscode-icons",
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "window.zoomLevel": 0,
    "emmet.triggerExpansionOnTab": true,
    "editor.formatOnType": true,
    "editor.formatOnPaste": true,
    "vsicons.dontShowNewVersionMessage": true,
    "security.workspace.trust.untrustedFiles": "open",
    "vim.handleKeys": {
        "<C-n>": false,
        "<C-p>": false,
        "<C-e>": false,
        "<C-a>": false,
        "<C-f>": false,
        "<C-b>": false
    },
    "claudeCode.preferredLocation": "panel",
    "gitlens.ai.model": "vscode",
    "gitlens.ai.vscode.model": "copilot:gpt-4.1",
    "workbench.colorTheme": "Light 2026",
    "git.autofetch": true,
    "githubPullRequests.pullBranch": "never",
    "window.openFoldersInNewWindow": "on",
    "window.openFilesInNewWindow": "on",
    "editor.accessibilitySupport": "on",
    "liveServer.settings.donotShowInfoMsg": true
}
SETTINGS_EOF
# 表示言語（日本語化）。ms-ceintl.vscode-language-pack-ja と組みで効く。
read -r -d '' LOCALE_JSON <<'LOCALE_EOF' || true
{
    "locale": "ja"
}
LOCALE_EOF
# ===== END VSCODE DATA =====

# code CLI を探す（PATH 優先、無ければアプリ同梱バイナリ）。
find_code() {
  if command -v code >/dev/null 2>&1; then
    command -v code
    return 0
  fi
  local p
  for p in \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
    "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
    if [ -x "$p" ]; then
      echo "$p"
      return 0
    fi
  done
  return 1
}

CODE="$(find_code || true)"
if [ -z "$CODE" ]; then
  echo "エラー: code CLI が見つかりません。先に Visual Studio Code をインストールしてください。" >&2
  exit 1
fi

# --export: いまのマシンの状態で DATA ブロックを差し替える。
if [ "${1:-}" = "--export" ]; then
  start='# ===== VSCODE DATA (auto-generated; refresh with: ./setup-vscode.sh --export) ====='
  end='# ===== END VSCODE DATA ====='
  tmp="$(mktemp)"
  {
    awk -v s="$start" '$0==s{exit} {print}' "$0"
    echo "$start"
    echo "EXTENSIONS=("
    "$CODE" --list-extensions | sort | sed 's/^/  /'
    echo ")"
    echo "read -r -d '' SETTINGS_JSON <<'SETTINGS_EOF' || true"
    cat "$USER_DIR/settings.json"
    echo "SETTINGS_EOF"
    echo "# 表示言語（日本語化）。ms-ceintl.vscode-language-pack-ja と組みで効く。"
    echo "read -r -d '' LOCALE_JSON <<'LOCALE_EOF' || true"
    if [ -f "$USER_DIR/locale.json" ]; then
      cat "$USER_DIR/locale.json"
    else
      printf '{\n    "locale": "ja"\n}\n'
    fi
    echo "LOCALE_EOF"
    echo "$end"
    awk -v e="$end" 'p{print} $0==e{p=1}' "$0"
  } > "$tmp"
  chmod +x "$tmp"
  mv "$tmp" "$0"
  echo "エクスポート完了: $0 を現在のマシンの状態で更新しました。"
  exit 0
fi

# --- 拡張機能をインストール ---
# 1 個失敗しても全体は止めず、失敗したものは最後にまとめて報告する。
echo "拡張機能を ${#EXTENSIONS[@]} 個インストールします..."
FAILED_EXTS=()
for ext in "${EXTENSIONS[@]}"; do
  if ! "$CODE" --install-extension "$ext" --force; then
    FAILED_EXTS+=("$ext")
  fi
done
if [ "${#FAILED_EXTS[@]}" -gt 0 ]; then
  echo "警告: 次の拡張機能はインストールできませんでした（提供終了などの可能性）: ${FAILED_EXTS[*]}" >&2
fi

# --- settings.json を反映（既存はバックアップ）---
mkdir -p "$USER_DIR"
if [ -f "$USER_DIR/settings.json" ]; then
  bak="$USER_DIR/settings.json.bak.$(date +%Y%m%d%H%M%S)"
  cp "$USER_DIR/settings.json" "$bak"
  echo "既存 settings.json をバックアップ: $bak"
fi
printf '%s\n' "$SETTINGS_JSON" > "$USER_DIR/settings.json"
echo "settings.json を反映しました: $USER_DIR/settings.json"

# --- locale.json を反映（日本語化。既存はバックアップ）---
if [ -f "$USER_DIR/locale.json" ]; then
  bak="$USER_DIR/locale.json.bak.$(date +%Y%m%d%H%M%S)"
  cp "$USER_DIR/locale.json" "$bak"
  echo "既存 locale.json をバックアップ: $bak"
fi
printf '%s\n' "$LOCALE_JSON" > "$USER_DIR/locale.json"
echo "locale.json を反映しました（表示言語: ja）: $USER_DIR/locale.json"

echo "完了。VSCode を再起動すると設定が反映されます。"
