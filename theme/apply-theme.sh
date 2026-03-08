#!/usr/bin/env bash

WALL="$1"

[ -z "$WALL" ] && echo "Usage: apply-theme.sh <wallpaper-path>" && exit 1
[ ! -f "$WALL" ] && echo "Error: '$WALL' not found" && exit 1

mkdir -p ~/.cache/matugen

# ── Set wallpaper ─────────────────────────────────────────────────
swww img "$WALL" --transition-type grow --transition-duration 5

# ── Extract colors with matugen ───────────────────────────────────
matugen image "$WALL" \
  -m dark \
  --type scheme-tonal-spot \
  --json hex \
  --contrast 0.3 \
  > ~/.cache/matugen/colors.json

# ── Render all config templates ───────────────────────────────────
~/.config/dotfiles/theme/render.sh

# ── Reload components ─────────────────────────────────────────────
# Waybar
pkill -x waybar; sleep 0.2
waybar &

# SwayNC
pkill -x swaync; sleep 0.2
swaync &

hyprctl reload

# Kitty (reload colors in all running instances)
if command -v kitty &>/dev/null; then
  for sock in /tmp/kitty-*; do
    kitty @ --to "unix:$sock" set-colors --all ~/.config/dotfiles/kitty/colors.conf 2>/dev/null
  done
fi

# GTK4 apps - signal to reload theme (newly opened apps pick it up automatically)
# For already-running GTK4/libadwaita apps, send USR1 or restart them
if command -v gsettings &>/dev/null; then
  # Toggle dark preference to force GTK4 apps to re-read CSS
  gsettings set org.gnome.desktop.interface color-scheme 'default'
  sleep 0.1
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi

# Disown background processes so they don't die with this script
disown 2>/dev/null
