#!/usr/bin/env bash

set -euo pipefail

TMP="$(mktemp --suffix=.png)"

cleanup() {
    rm -f "$TMP"
}

trap cleanup EXIT

# Capture selected area
grim -g "$(slurp)" "$TMP"

# OCR
TEXT="$(
    tesseract "$TMP" stdout \
        -l eng+ben+hin \
        --psm 6 \
        2>/dev/null
)"

# Copy if any text was recognized
if [[ -n "$TEXT" ]]; then
    printf "%s" "$TEXT" | wl-copy
    notify-send "OCR" "Text copied to clipboard"
else
    notify-send "OCR" "No text detected"
fi
