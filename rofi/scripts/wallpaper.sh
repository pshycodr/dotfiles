#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
CACHE="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$CACHE"

choice=$(find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r img; do

    thumb="$CACHE/$(basename "$img")"

    if [ ! -f "$thumb" ]; then
        ffmpegthumbnailer -i "$img" -o "$thumb" -s 256
    fi

    echo -en "$img\x00icon\x1f$thumb\n"

done | rofi -dmenu -theme ~/.config/rofi/wallpaper.rasi)

[ -z "$choice" ] && exit

~/.config/dotfiles/theme/apply-theme.sh "$choice" 
