#!/bin/bash
#
# claude-session-reaper.sh
#
# 起動から一定時間(既定 36 時間)以上経過した Claude Code の CLI セッション
# (`claude` バイナリ)を検出し、TERM -> KILL で終了させる。
#
# 目的: 閉じ忘れ / ハングした古いセッションが CPU を焼き続けたり
#       メモリ(1 個あたり ~70-260MB)を積み上げるのを防ぐ。
# 安全性: Claude Code の会話ログはディスクに保存され `claude --resume` で
#         復元できるため、失うのはメモリ上の実行状態のみ。
#
# launchd(LaunchAgent)から 6 時間ごとに起動される想定。手動実行も可。
#   THRESHOLD_HOURS=0 DRY_RUN=1 ./claude-session-reaper.sh  # 全 claude を列挙(kill しない)
#
set -u
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

THRESHOLD_HOURS="${THRESHOLD_HOURS:-36}"
DRY_RUN="${DRY_RUN:-0}"                 # 1 なら kill せずログのみ
THRESHOLD_SECS=$(( THRESHOLD_HOURS * 3600 ))

LOG_DIR="$HOME/Library/Logs/claude-session-reaper"
LOG_FILE="$LOG_DIR/reaper.log"
mkdir -p "$LOG_DIR"

ts() { date '+%Y-%m-%d %H:%M:%S'; }
log() { printf '%s %s\n' "$(ts)" "$1" >> "$LOG_FILE"; }

# etime 形式 [[dd-]hh:]mm:ss を秒に変換
etime_to_secs() {
  local t="$1" dd=0 hh=0 mm=0 ss=0
  [ -z "$t" ] && { echo 0; return; }
  if [[ "$t" == *-* ]]; then dd="${t%%-*}"; t="${t#*-}"; fi
  local IFS=:
  # shellcheck disable=SC2206
  local parts=($t)
  local n=${#parts[@]}
  if   (( n == 3 )); then hh="${parts[0]}"; mm="${parts[1]}"; ss="${parts[2]}"
  elif (( n == 2 )); then mm="${parts[0]}"; ss="${parts[1]}"
  elif (( n == 1 )); then ss="${parts[0]}"
  fi
  echo $(( 10#${dd:-0}*86400 + 10#${hh:-0}*3600 + 10#${mm:-0}*60 + 10#${ss:-0} ))
}

# 対象 pid の作業ディレクトリ(ログ用・失敗しても無視)
cwd_of() {
  lsof -a -p "$1" -d cwd -Fn 2>/dev/null | grep '^n' | head -1 | cut -c2-
}

reaped=0
scanned=0

# comm が厳密に "claude"(小文字)のものだけを対象にする。
# デスクトップアプリは comm が "Claude" / "Claude Helper" なので自然に除外される。
while read -r pid comm; do
  [ -n "$pid" ] || continue
  base="$(basename "$comm" 2>/dev/null)"
  [ "$base" = "claude" ] || continue
  scanned=$(( scanned + 1 ))

  et="$(ps -o etime= -p "$pid" 2>/dev/null | tr -d ' ')"
  secs="$(etime_to_secs "$et")"
  (( secs >= THRESHOLD_SECS )) || continue

  cwd="$(cwd_of "$pid")"
  hrs=$(( secs / 3600 ))

  if [ "$DRY_RUN" = "1" ]; then
    log "DRY-RUN would reap pid=$pid etime=$et (~${hrs}h) cwd=${cwd:-?}"
    continue
  fi

  log "reaping pid=$pid etime=$et (~${hrs}h) cwd=${cwd:-?}"
  kill -TERM "$pid" 2>/dev/null
  # 最大 5 秒待って落ちなければ強制
  for _ in 1 2 3 4 5; do
    kill -0 "$pid" 2>/dev/null || break
    sleep 1
  done
  if kill -0 "$pid" 2>/dev/null; then
    kill -9 "$pid" 2>/dev/null
    log "  -> SIGKILL pid=$pid"
  else
    log "  -> terminated pid=$pid"
  fi
  reaped=$(( reaped + 1 ))
done < <(ps -axo pid=,comm=)

log "run complete: scanned=$scanned claude sessions, reaped=$reaped (threshold=${THRESHOLD_HOURS}h, dry_run=${DRY_RUN})"
