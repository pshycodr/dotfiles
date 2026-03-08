#!/usr/bin/env bash
# Run this ONCE to configure wallust to output colors.json on every `wallust run`
# After this, apply-theme.sh will work correctly.

set -e

TMPL_DIR="$HOME/.config/wallust/templates"
TMPL_FILE="$TMPL_DIR/colors.json"
TOML_FILE="$HOME/.config/wallust/wallust.toml"
CACHE_DIR="$HOME/.cache/wallust"

echo "── Setting up wallust JSON template ─────────────────────────"

# 1. Create template directory and file
mkdir -p "$TMPL_DIR" "$CACHE_DIR"

cat > "$TMPL_FILE" << 'TMPL'
{
  "colors": {
    "color0":  "{{color0}}",
    "color1":  "{{color1}}",
    "color2":  "{{color2}}",
    "color3":  "{{color3}}",
    "color4":  "{{color4}}",
    "color5":  "{{color5}}",
    "color6":  "{{color6}}",
    "color7":  "{{color7}}",
    "color8":  "{{color8}}",
    "color9":  "{{color9}}",
    "color10": "{{color10}}",
    "color11": "{{color11}}",
    "color12": "{{color12}}",
    "color13": "{{color13}}",
    "color14": "{{color14}}",
    "color15": "{{color15}}"
  },
  "special": {
    "background": "{{background}}",
    "foreground": "{{foreground}}",
    "cursor":     "{{cursor}}"
  }
}
TMPL

echo "  ✓ Template written to $TMPL_FILE"

# 2. Add [[templates]] entry to wallust.toml if not already present
if [ ! -f "$TOML_FILE" ]; then
  echo "  Creating $TOML_FILE"
  cat > "$TOML_FILE" << TOML
[[templates]]
template = "$TMPL_FILE"
target   = "$CACHE_DIR/colors.json"
TOML
  echo "  ✓ Created $TOML_FILE with template entry"
else
  # Check if our entry already exists
  if grep -q "cache/wallust/colors.json" "$TOML_FILE"; then
    echo "  ✓ Template entry already present in $TOML_FILE — skipping"
  else
    # Append to existing toml
    cat >> "$TOML_FILE" << TOML

[[templates]]
template = "$TMPL_FILE"
target   = "$CACHE_DIR/colors.json"
TOML
    echo "  ✓ Appended template entry to $TOML_FILE"
  fi
fi

echo ""
echo "── Setup complete. Now run: ──────────────────────────────────"
echo "   ~/.config/dotfiles/theme/apply-theme.sh <wallpaper-path>"
