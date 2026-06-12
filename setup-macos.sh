#!/usr/bin/env bash
#
# setup-macos.sh — 新しい Mac の macOS 設定を反映するスクリプト。
#
# GUI（システム設定）からは設定できない / しづらい項目を defaults で明示的に書く。
#
set -euo pipefail

# --- トラックパッドのポインタ速度 ---
# システム設定の最大は 3.0 だが、それより速い 5 を直接書く。
# 反映はログアウト / 再起動後。
defaults write -g com.apple.trackpad.scaling -float 5

# --- Finder で隠しファイルを常に表示 ---
# ⌘⇧. のトグルだと誤操作で戻るため、明示的に true を書く。
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder

echo "macOS 設定を反映しました。トラックパッド速度はログアウト / 再起動後に有効になります。"
