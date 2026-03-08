#!/usr/bin/env bash

WALL="$1"

[ -z "$WALL" ] && echo "Usage: apply-theme.sh <wallpaper-path>" && exit 1
[ ! -f "$WALL" ] && echo "Error: '$WALL' not found" && exit 1

mkdir -p ~/.cache/matugen

# ── Set wallpaper ─────────────────────────────────────────────────
swww img "$WALL" --transition-type grow --transition-duration 3

# ── Auto-extract dominant color using ImageMagick ─────────────────
# Resize to speed up, quantize to 1 color, output as hex
SOURCE_COLOR=$(convert "$WALL" \
  -resize 200x200^ \
  -gravity center \
  -extent 200x200 \
  +dither -quantize transparent -colors 1 \
  -unique-colors txt:- 2>/dev/null \
  | grep -v '^#' \
  | head -1 \
  | grep -oP '#[0-9A-Fa-f]{6}')

# Fallback: k-means dominant color
if [ -z "$SOURCE_COLOR" ]; then
  SOURCE_COLOR=$(convert "$WALL" \
    -resize 100x100! \
    -kmeans 5 \
    -unique-colors txt:- 2>/dev/null \
    | grep -v '^#' \
    | awk 'NR==1 { match($0, /#[0-9A-Fa-f]{6}/); print substr($0, RSTART, RLENGTH) }')
fi

# Fallback: average color of the image
if [ -z "$SOURCE_COLOR" ]; then
  SOURCE_COLOR=$(convert "$WALL" \
    -resize 1x1! \
    -format "%[fx:floor(255*r+.5)],%[fx:floor(255*g+.5)],%[fx:floor(255*b+.5)]" info: \
    | awk -F',' '{ printf "#%02x%02x%02x\n", $1, $2, $3 }')
fi

echo "Using source color: $SOURCE_COLOR"

# ── Extract colors with matugen ───────────────────────────────────
/home/pshycodr/.cargo/bin/matugen color hex "$SOURCE_COLOR" \
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
waybar  &

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
