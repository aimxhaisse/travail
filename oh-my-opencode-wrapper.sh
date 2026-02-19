#!/bin/bash
set -e

# This wrapper runs opencode with the oh-my-opencode plugin enabled.
# We use a separate XDG_CONFIG_HOME so the vanilla `opencode` command
# continues to use the host config unmodified.

CUSTOM_CONFIG_DIR="$HOME/.config/opencode-omo"
TARGET_CONFIG_FILE="$CUSTOM_CONFIG_DIR/opencode/opencode.json"
ORIG_CONFIG_FILE="$HOME/.config/opencode/opencode.json"

mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"

if [ -f "$ORIG_CONFIG_FILE" ]; then
    jq 'if .plugin then . else . + {plugin: []} end | .plugin += ["oh-my-opencode"] | .plugin |= unique' "$ORIG_CONFIG_FILE" > "$TARGET_CONFIG_FILE"
else
    echo '{"plugin": ["oh-my-opencode"]}' > "$TARGET_CONFIG_FILE"
fi

export XDG_CONFIG_HOME="$CUSTOM_CONFIG_DIR"

OPENCODE_BIN="$HOME/.opencode/bin/opencode"

if [ -x "$OPENCODE_BIN" ]; then
    exec "$OPENCODE_BIN" "$@"
else
    exec opencode "$@"
fi
