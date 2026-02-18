#!/bin/bash
set -e

# Define directories
# We use a custom XDG_CONFIG_HOME to force opencode to read our modified config
CUSTOM_CONFIG_DIR="$HOME/.config/opencode-omo"
TARGET_CONFIG_FILE="$CUSTOM_CONFIG_DIR/opencode/opencode.json"
ORIG_CONFIG_FILE="$HOME/.config/opencode/opencode.json"

# Ensure directory exists
mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"

# Logic:
# 1. If host config exists, copy it and append plugin.
# 2. If no host config, create new config with plugin.

if [ -f "$ORIG_CONFIG_FILE" ]; then
    # Use jq to safely add the plugin to the existing list, ensuring no duplicates
    # We use a temporary file to avoid issues
    jq 'if .plugins then . else . + {plugins: []} end | .plugins += ["oh-my-opencode"] | .plugins |= unique' "$ORIG_CONFIG_FILE" > "$TARGET_CONFIG_FILE"
else
    echo '{"plugins": ["oh-my-opencode"]}' > "$TARGET_CONFIG_FILE"
fi

# Set XDG_CONFIG_HOME to our custom directory
export XDG_CONFIG_HOME="$CUSTOM_CONFIG_DIR"

# Execute opencode from its installed location
# We assume opencode is in the PATH or at the standard install location
OPENCODE_BIN="$HOME/.opencode/bin/opencode"

if [ -x "$OPENCODE_BIN" ]; then
    exec "$OPENCODE_BIN" "$@"
else
    # Fallback to PATH
    exec opencode "$@"
fi
