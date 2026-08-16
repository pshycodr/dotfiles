#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON="$DIR/.venvs/py3-12/bin/python"

TMP="$(mktemp --suffix=.png)"

cleanup() {
    rm -f "$TMP"
}

trap cleanup EXIT

grim -g "$(slurp)" "$TMP"

TEXT="$("$PYTHON" "$DIR/main.py" "$TMP")"

printf "%s" "$TEXT" | wl-copy

notify-send "OCR" "Copied to clipboard"
