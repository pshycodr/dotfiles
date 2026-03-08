#!/usr/bin/env bash

TEMPLATES="$HOME/.config/dotfiles/theme/templates"
COLORS="$HOME/.cache/matugen/colors.json"

[ ! -f "$COLORS" ] && echo "Error: $COLORS not found. Run matugen first." && exit 1

# ── colors from matugen JSON ──────────────────────────
primary=$(jq -r '.colors.primary.dark.color' "$COLORS")
secondary=$(jq -r '.colors.secondary.dark.color' "$COLORS")
tertiary=$(jq -r '.colors.tertiary.dark.color' "$COLORS")

background=$(jq -r '.colors.background.dark.color' "$COLORS")
surface=$(jq -r '.colors.surface.dark.color' "$COLORS")
surface_dim=$(jq -r '.colors.surface_dim.dark.color' "$COLORS")
surface_bright=$(jq -r '.colors.surface_bright.dark.color' "$COLORS")
surface_container=$(jq -r '.colors.surface_container.dark.color' "$COLORS")
surface_container_low=$(jq -r '.colors.surface_container_low.dark.color' "$COLORS")
surface_container_high=$(jq -r '.colors.surface_container_high.dark.color' "$COLORS")
surface_container_highest=$(jq -r '.colors.surface_container_highest.dark.color' "$COLORS")
surface_container_lowest=$(jq -r '.colors.surface_container_lowest.dark.color' "$COLORS")
surface_variant=$(jq -r '.colors.surface_variant.dark.color' "$COLORS")

primary_container=$(jq -r '.colors.primary_container.dark.color' "$COLORS")
secondary_container=$(jq -r '.colors.secondary_container.dark.color' "$COLORS")
tertiary_container=$(jq -r '.colors.tertiary_container.dark.color' "$COLORS")

on_primary=$(jq -r '.colors.on_primary.dark.color' "$COLORS")
on_secondary=$(jq -r '.colors.on_secondary.dark.color' "$COLORS")
on_tertiary=$(jq -r '.colors.on_tertiary.dark.color' "$COLORS")
on_background=$(jq -r '.colors.on_background.dark.color' "$COLORS")
onSurface=$(jq -r '.colors.on_surface.dark.color' "$COLORS")
onSurfaceVariant=$(jq -r '.colors.on_surface_variant.dark.color' "$COLORS")
on_primary_container=$(jq -r '.colors.on_primary_container.dark.color' "$COLORS")
on_secondary_container=$(jq -r '.colors.on_secondary_container.dark.color' "$COLORS")
on_tertiary_container=$(jq -r '.colors.on_tertiary_container.dark.color' "$COLORS")

outline=$(jq -r '.colors.outline.dark.color' "$COLORS")
outline_variant=$(jq -r '.colors.outline_variant.dark.color' "$COLORS")
error=$(jq -r '.colors.error.dark.color' "$COLORS")
error_container=$(jq -r '.colors.error_container.dark.color' "$COLORS")

inverse_surface=$(jq -r '.colors.inverse_surface.dark.color' "$COLORS")
inverse_primary=$(jq -r '.colors.inverse_primary.dark.color' "$COLORS")
inverse_on_surface=$(jq -r '.colors.inverse_on_surface.dark.color' "$COLORS")

shadow=$(jq -r '.colors.shadow.dark.color' "$COLORS")

export primary secondary tertiary
export background surface surface_dim surface_bright
export surface_container surface_container_low surface_container_high
export surface_container_highest surface_container_lowest surface_variant
export primary_container secondary_container tertiary_container
export on_primary on_secondary on_tertiary on_background
export onSurface onSurfaceVariant
export on_primary_container on_secondary_container on_tertiary_container
export outline outline_variant error error_container
export inverse_surface inverse_primary inverse_on_surface shadow

# ── Helper: strip '#' from hex color ──────────────────────────────
strip_hash() { echo "${1#\#}"; }

# ── Helper: hex to rgba ──────────────────────────────────────────
hex_to_rgba() {
    local hex="${1#\#}"
    local alpha="${2:-0.9}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    echo "rgba($r,$g,$b,$alpha)"
}

# ── List of vars to substitute (prevents envsubst from eating $var in templates) ──
VARS='$primary $secondary $tertiary
$background $surface $surface_dim $surface_bright
$surface_container $surface_container_low $surface_container_high
$surface_container_highest $surface_container_lowest $surface_variant
$primary_container $secondary_container $tertiary_container
$on_primary $on_secondary $on_tertiary $on_background
$onSurface $onSurfaceVariant
$on_primary_container $on_secondary_container $on_tertiary_container
$outline $outline_variant $error $error_container
$inverse_surface $inverse_primary $inverse_on_surface $shadow'

# ── No-hash variants for Hyprland (rgb() expects hex without #) ──
primary_nohash=$(strip_hash "$primary")
surface_variant_nohash=$(strip_hash "$surface_variant")
shadow_nohash=$(strip_hash "$shadow")
export primary_nohash surface_variant_nohash shadow_nohash
HYPR_VARS='$primary_nohash $surface_variant_nohash $shadow_nohash'

# ── Render templates ──────────────────────────────────────────────
envsubst "$VARS" < "$TEMPLATES/waybar.css"      > ~/.config/dotfiles/waybar/colors/dynamic.css
envsubst "$VARS" < "$TEMPLATES/rofi.rasi"        > ~/.config/dotfiles/rofi/colors/dynamic.rasi
envsubst "$VARS" < "$TEMPLATES/swaync.css"       > ~/.config/dotfiles/swaync/colors/dynamic.css
envsubst "$VARS $HYPR_VARS" < "$TEMPLATES/hyprland.conf"    > ~/.config/dotfiles/hypr/dynamic.conf
envsubst "$VARS" < "$TEMPLATES/alacritty.toml"   > ~/.config/dotfiles/alacritty/colors.toml
envsubst "$VARS" < "$TEMPLATES/kitty.conf"       > ~/.config/dotfiles/kitty/colors.conf

# ── GTK-4.0: sed-replace catppuccin mocha colors with dynamic ones ──
GTK4_DIR="$HOME/.config/dotfiles/gtk-4.0"
if [ -f "$GTK4_DIR/gtk-base.css" ]; then
    # Helper: hex (#RRGGBB) to "R, G, B" for rgba() replacement
    hex_to_rgb_tuple() {
        local hex="${1#\#}"
        printf "%d, %d, %d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
    }

    # Catppuccin Mocha → Dynamic color mapping
    # Hex replacements
    SED_ARGS=(
        -e "s/#a6e3a1/${primary}/gI"          # green/accent → primary
        -e "s/#eff1f5/${onSurface}/gI"         # text → onSurface
        -e "s/#1e1e2e/${background}/gI"        # base → background
        -e "s/#181825/${surface_container_low}/gI"  # mantle → surface_container_low
        -e "s/#11111b/${surface_container_lowest}/gI" # crust → surface_container_lowest
        -e "s/#313244/${surface_container_high}/gI" # surface1 → surface_container_high
        -e "s/#45475a/${surface_variant}/gI"   # surface0 → surface_variant
        -e "s/#f38ba8/${error}/gI"             # red → error
        -e "s/#f9e2af/${tertiary}/gI"          # yellow → tertiary
        -e "s/#89b4fa/${secondary}/gI"         # blue → secondary
        -e "s/#fab387/${tertiary_container}/gI" # peach → tertiary_container
    )

    # rgba() replacements (catppuccin mocha RGB tuples)
    SED_ARGS+=(
        -e "s/rgba(166, 227, 161/rgba($(hex_to_rgb_tuple "$primary")/g"   # green
        -e "s/rgba(239, 241, 245/rgba($(hex_to_rgb_tuple "$onSurface")/g" # text
        -e "s/rgba(30, 30, 46/rgba($(hex_to_rgb_tuple "$background")/g"   # base
        -e "s/rgba(24, 24, 37/rgba($(hex_to_rgb_tuple "$surface_container_low")/g" # mantle
        -e "s/rgba(49, 50, 68/rgba($(hex_to_rgb_tuple "$surface_container_high")/g" # surface1
        -e "s/rgba(69, 71, 90/rgba($(hex_to_rgb_tuple "$surface_variant")/g" # surface0
        -e "s/rgba(243, 139, 168/rgba($(hex_to_rgb_tuple "$error")/g"     # red
        -e "s/rgba(249, 226, 175/rgba($(hex_to_rgb_tuple "$tertiary")/g"  # yellow
        -e "s/rgba(137, 180, 250/rgba($(hex_to_rgb_tuple "$secondary")/g" # blue
    )

    sed "${SED_ARGS[@]}" "$GTK4_DIR/gtk-base.css" > "$GTK4_DIR/gtk.css"
    sed "${SED_ARGS[@]}" "$GTK4_DIR/gtk-dark-base.css" > "$GTK4_DIR/gtk-dark.css"
fi

# ── Hyprlock colors (needs special generation for accent ramps) ──
primary_hex=$(strip_hash "$primary")
secondary_hex=$(strip_hash "$secondary")
tertiary_hex=$(strip_hash "$tertiary")
surface_hex=$(strip_hash "$surface")
onSurface_hex=$(strip_hash "$onSurface")
background_hex=$(strip_hash "$background")
primary_container_hex=$(strip_hash "$primary_container")
surface_container_hex=$(strip_hash "$surface_container")
surface_container_high_hex=$(strip_hash "$surface_container_high")
on_primary_container_hex=$(strip_hash "$on_primary_container")
outline_hex=$(strip_hash "$outline")

cat > ~/.config/dotfiles/hyprlock/colors.conf << EOF
# Auto-generated by render.sh from wallpaper colors

# Color group 1 — Primary
\$primary_1       = ${background_hex}
\$text_1          = ${onSurface_hex}
\$p1_accent_1     = ${surface_hex}
\$p1_accent_2     = ${surface_container_hex}
\$p1_accent_3     = ${surface_container_high_hex}
\$p1_accent_4     = $(strip_hash "$outline")
\$p1_accent_5     = $(strip_hash "$primary_container")
\$p1_accent_6     = $(strip_hash "$primary")
\$p1_accent_7     = $(strip_hash "$on_primary_container")
\$p1_accent_8     = $(strip_hash "$onSurface")
\$p1_accent_9     = $(strip_hash "$inverse_on_surface")

# rgba
\$primary_1_rgba       = $(hex_to_rgba "$background" 0.9)
\$text_1_rgba          = $(hex_to_rgba "$onSurface" 0.9)
\$p1_accent_1_rgba     = $(hex_to_rgba "$surface" 0.9)
\$p1_accent_2_rgba     = $(hex_to_rgba "$surface_container" 0.9)
\$p1_accent_3_rgba     = $(hex_to_rgba "$surface_container_high" 0.9)
\$p1_accent_4_rgba     = $(hex_to_rgba "$outline" 0.9)
\$p1_accent_5_rgba     = $(hex_to_rgba "$primary_container" 0.9)
\$p1_accent_6_rgba     = $(hex_to_rgba "$primary" 0.9)
\$p1_accent_7_rgba     = $(hex_to_rgba "$on_primary_container" 0.9)
\$p1_accent_8_rgba     = $(hex_to_rgba "$onSurface" 0.9)
\$p1_accent_9_rgba     = $(hex_to_rgba "$inverse_on_surface" 0.9)

# Color group 2 — Secondary
\$primary_2       = $(strip_hash "$secondary_container")
\$text_2          = $(strip_hash "$on_secondary_container")
\$p2_accent_1     = $(strip_hash "$surface")
\$p2_accent_2     = $(strip_hash "$surface_container")
\$p2_accent_3     = $(strip_hash "$surface_container_high")
\$p2_accent_4     = $(strip_hash "$outline")
\$p2_accent_5     = $(strip_hash "$secondary_container")
\$p2_accent_6     = $(strip_hash "$secondary")
\$p2_accent_7     = $(strip_hash "$on_secondary_container")
\$p2_accent_8     = $(strip_hash "$onSurface")
\$p2_accent_9     = $(strip_hash "$inverse_on_surface")

# rgba
\$primary_2_rgba       = $(hex_to_rgba "$secondary_container" 0.9)
\$text_2_rgba          = $(hex_to_rgba "$on_secondary_container" 0.9)
\$p2_accent_1_rgba     = $(hex_to_rgba "$surface" 0.9)
\$p2_accent_2_rgba     = $(hex_to_rgba "$surface_container" 0.9)
\$p2_accent_3_rgba     = $(hex_to_rgba "$surface_container_high" 0.9)
\$p2_accent_4_rgba     = $(hex_to_rgba "$outline" 0.9)
\$p2_accent_5_rgba     = $(hex_to_rgba "$secondary_container" 0.9)
\$p2_accent_6_rgba     = $(hex_to_rgba "$secondary" 0.9)
\$p2_accent_7_rgba     = $(hex_to_rgba "$on_secondary_container" 0.9)
\$p2_accent_8_rgba     = $(hex_to_rgba "$onSurface" 0.9)
\$p2_accent_9_rgba     = $(hex_to_rgba "$inverse_on_surface" 0.9)

# Color group 3 — Tertiary
\$primary_3       = $(strip_hash "$tertiary_container")
\$text_3          = $(strip_hash "$on_tertiary_container")
\$p3_accent_1     = $(strip_hash "$surface")
\$p3_accent_2     = $(strip_hash "$surface_container")
\$p3_accent_3     = $(strip_hash "$surface_container_high")
\$p3_accent_4     = $(strip_hash "$outline")
\$p3_accent_5     = $(strip_hash "$tertiary_container")
\$p3_accent_6     = $(strip_hash "$tertiary")
\$p3_accent_7     = $(strip_hash "$on_tertiary_container")
\$p3_accent_8     = $(strip_hash "$onSurface")
\$p3_accent_9     = $(strip_hash "$inverse_on_surface")

# rgba
\$primary_3_rgba       = $(hex_to_rgba "$tertiary_container" 0.9)
\$text_3_rgba          = $(hex_to_rgba "$on_tertiary_container" 0.9)
\$p3_accent_1_rgba     = $(hex_to_rgba "$surface" 0.9)
\$p3_accent_2_rgba     = $(hex_to_rgba "$surface_container" 0.9)
\$p3_accent_3_rgba     = $(hex_to_rgba "$surface_container_high" 0.9)
\$p3_accent_4_rgba     = $(hex_to_rgba "$outline" 0.9)
\$p3_accent_5_rgba     = $(hex_to_rgba "$tertiary_container" 0.9)
\$p3_accent_6_rgba     = $(hex_to_rgba "$tertiary" 0.9)
\$p3_accent_7_rgba     = $(hex_to_rgba "$on_tertiary_container" 0.9)
\$p3_accent_8_rgba     = $(hex_to_rgba "$onSurface" 0.9)
\$p3_accent_9_rgba     = $(hex_to_rgba "$inverse_on_surface" 0.9)

# Color group 4 — Inverse/Accent
\$primary_4       = $(strip_hash "$inverse_primary")
\$text_4          = $(strip_hash "$inverse_on_surface")
\$p4_accent_1     = $(strip_hash "$surface")
\$p4_accent_2     = $(strip_hash "$surface_container")
\$p4_accent_3     = $(strip_hash "$surface_container_high")
\$p4_accent_4     = $(strip_hash "$outline")
\$p4_accent_5     = $(strip_hash "$primary_container")
\$p4_accent_6     = $(strip_hash "$inverse_primary")
\$p4_accent_7     = $(strip_hash "$on_primary_container")
\$p4_accent_8     = $(strip_hash "$onSurface")
\$p4_accent_9     = $(strip_hash "$inverse_on_surface")

# rgba
\$primary_4_rgba       = $(hex_to_rgba "$inverse_primary" 0.9)
\$text_4_rgba          = $(hex_to_rgba "$inverse_on_surface" 0.9)
\$p4_accent_1_rgba     = $(hex_to_rgba "$surface" 0.9)
\$p4_accent_2_rgba     = $(hex_to_rgba "$surface_container" 0.9)
\$p4_accent_3_rgba     = $(hex_to_rgba "$surface_container_high" 0.9)
\$p4_accent_4_rgba     = $(hex_to_rgba "$outline" 0.9)
\$p4_accent_5_rgba     = $(hex_to_rgba "$primary_container" 0.9)
\$p4_accent_6_rgba     = $(hex_to_rgba "$inverse_primary" 0.9)
\$p4_accent_7_rgba     = $(hex_to_rgba "$on_primary_container" 0.9)
\$p4_accent_8_rgba     = $(hex_to_rgba "$onSurface" 0.9)
\$p4_accent_9_rgba     = $(hex_to_rgba "$inverse_on_surface" 0.9)

# half-opacity variants
\$primary_5_rgba   = $(hex_to_rgba "$background" 0.5)
\$primary_6_rgba   = $(hex_to_rgba "$secondary_container" 0.5)
\$primary_7_rgba   = $(hex_to_rgba "$tertiary_container" 0.5)
\$primary_8_rgba   = $(hex_to_rgba "$inverse_primary" 0.5)
EOF

echo "ok"
