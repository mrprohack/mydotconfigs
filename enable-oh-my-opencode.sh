#!/bin/bash
set -e

CONFIG_FILE="$HOME/.config/opencode/opencode.json"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: opencode.json not found at $CONFIG_FILE"
    exit 1
fi

if grep -q '"oh-my-opencode"' "$CONFIG_FILE"; then
    echo "oh-my-opencode is already enabled in opencode.json"
    exit 0
fi

jq '.plugin |= if . == null then ["oh-my-opencode"] else . + ["oh-my-opencode"] end' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully enabled oh-my-opencode in opencode.json"
else
    echo "Error: Failed to enable oh-my-opencode"
    exit 1
fi
