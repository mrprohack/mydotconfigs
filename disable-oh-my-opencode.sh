#!/bin/bash
set -e

CONFIG_FILE="$HOME/.config/opencode/opencode.json"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: opencode.json not found at $CONFIG_FILE"
    exit 1
fi

if ! grep -q '"oh-my-opencode"' "$CONFIG_FILE"; then
    echo "oh-my-opencode is not present in opencode.json"
    exit 0
fi

jq '.plugin |= map(select(. != "oh-my-opencode"))' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully disabled oh-my-opencode in opencode.json"
else
    echo "Error: Failed to disable oh-my-opencode"
    exit 1
fi
