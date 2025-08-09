#!/usr/bin/env bash
set -u

# Usage: notify_post.sh <action> <exit_code> [payload_json]

ACTION="${1:-}"
EXIT_CODE="${2:-0}"
PAYLOAD="${3:-}"

if [[ -z "$ACTION" ]]; then
  echo "Usage: $0 <action> <exit_code> [payload_json]" >&2
  exit 2
fi

find_hooks_dir() {
  local dir
  dir="$(pwd)"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.claude/hooks" ]]; then
      echo "$dir/.claude/hooks"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

if ! HOOKS_DIR=$(find_hooks_dir); then
  exit 0
fi

export HOOK_ACTION="$ACTION"
export HOOK_EXIT_CODE="$EXIT_CODE"
export HOOK_PAYLOAD="$PAYLOAD"
export HOOK_TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export HOOK_CWD="$(pwd)"

python3 "$HOOKS_DIR/post_tool_use.py" || true
exit 0


