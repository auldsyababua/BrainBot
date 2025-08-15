#!/usr/bin/env bash

# Cursor/KiroHooks integration wrapper
# - Runs .claude/hooks/pre_tool_use.py before the command
# - Runs .claude/hooks/post_tool_use.py after the command
# - Passes context via environment variables
# - If pre hook exits non-zero, the command is blocked

set -u

timestamp() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

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

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <command string>"
  exit 2
fi

COMMAND_STR="$*"
HOOKS_DIR=""
if HOOKS_DIR=$(find_hooks_dir); then
  PRE_HOOK="$HOOKS_DIR/pre_tool_use.py"
  POST_HOOK="$HOOKS_DIR/post_tool_use.py"
else
  PRE_HOOK=""
  POST_HOOK=""
fi

# Export context for hooks
export HOOK_COMMAND="$COMMAND_STR"
export HOOK_CWD="$(pwd)"
export HOOK_TS="$(timestamp)"
export HOOK_SHELL="${SHELL:-/bin/bash}"

# Run pre hook if present
if [[ -n "$PRE_HOOK" && -f "$PRE_HOOK" ]]; then
  python3 "$PRE_HOOK" || {
    echo "❌ Blocked by pre_tool_use hook: $PRE_HOOK"
    exit 99
  }
fi

# Execute the command, capturing output
TMP_OUT="$(mktemp)"
TMP_ERR="$(mktemp)"
set +e
eval "$COMMAND_STR" >"$TMP_OUT" 2>"$TMP_ERR"
EXIT_CODE=$?
set -e

# Run post hook if present
export HOOK_EXIT_CODE="$EXIT_CODE"
export HOOK_STDOUT_FILE="$TMP_OUT"
export HOOK_STDERR_FILE="$TMP_ERR"
if [[ -n "$POST_HOOK" && -f "$POST_HOOK" ]]; then
  python3 "$POST_HOOK" || true
fi

# Relay original command output
cat "$TMP_OUT"
cat "$TMP_ERR" >&2

rm -f "$TMP_OUT" "$TMP_ERR"
exit "$EXIT_CODE"


