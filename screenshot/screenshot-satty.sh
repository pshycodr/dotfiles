#!/usr/bin/env bash

# Directory for screenshots
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Mode passed from bind: output | region | window
mode="$1"

# Timestamped name
timestamp=$(date '+%Y%m%d-%H%M%S')
outfile="$SAVE_DIR/screenshot-$mode-$timestamp.png"

# Take screenshot raw, annotate with satty
hyprshot -m "$mode" --raw | satty \
  --filename - \
  --output-filename "$outfile" \
  --copy-command "wl-copy" \
  --actions-on-enter "save-to-file,save-to-clipboard,exit"

# After satty exits, notify with an image and path
notify-send -i "$outfile" "Screenshot saved" "$outfile"

