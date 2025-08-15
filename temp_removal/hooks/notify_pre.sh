#!/usr/bin/env bash
set -u

# Usage: notify_pre.sh <action> [payload_json]
# Finds nearest .claude/hooks and runs pre_tool_use.py with HOOK_ envs.

ACTION="${1:-}"
PAYLOAD="${2:-}"

if [[ -z "$ACTION" ]]; then
  echo "Usage: $0 <action> [payload_json]" >&2
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
  # No hooks; allow
  exit 0
fi

export HOOK_ACTION="$ACTION"
export HOOK_PAYLOAD="$PAYLOAD"
export HOOK_TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
export HOOK_CWD="$(pwd)"

python3 "$HOOKS_DIR/pre_tool_use.py"
exit $?


