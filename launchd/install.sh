#!/bin/bash
#
# install.sh — claude-session-reaper の LaunchAgent をこのマシンに登録する。
#
# dotfiles を clone した先で実行すると、6 時間ごとに古い Claude Code CLI
# セッション(起動から 28H 超)を終了する監視が有効になる。
# 冪等: 何度実行しても既存を bootout してから再登録する。
#
set -eu

LABEL="com.sunouchi.claude-session-reaper"
DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_SRC="$DIR/${LABEL}.plist"
PLIST_DST="$HOME/Library/LaunchAgents/${LABEL}.plist"

[ -f "$PLIST_SRC" ] || { echo "plist が見つからない: $PLIST_SRC" >&2; exit 1; }

mkdir -p "$HOME/Library/LaunchAgents" "$HOME/Library/Logs/claude-session-reaper"

plutil -lint "$PLIST_SRC" >/dev/null
cp -f "$PLIST_SRC" "$PLIST_DST"

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST_DST"

echo "登録完了: $LABEL"
launchctl print "gui/$(id -u)/$LABEL" 2>/dev/null | grep -E 'run interval|program =' | head -2 || true
echo "ログ: ~/Library/Logs/claude-session-reaper/reaper.log"
