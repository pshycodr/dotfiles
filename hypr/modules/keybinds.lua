local mainMod = "ALT"

local browser = "zen-browser"
local terminal = "kitty"
local fileManager = "nautilus"

-- local menu = "rofi -show drun -theme ~/.config/rofi/catppuccin.rasi"
local menu = "~/.config/rofi/launchers/launcher.sh"

-- ── Core Apps ─────────────────────────────────────────────────────────────────

-- Launch terminal
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

-- Kill focused window
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.window.close())

-- Launch file manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Toggle floating for focused window
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Open app launcher (rofi)
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd(menu))

-- Toggle dwindle pseudotiling
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Toggle dwindle split orientation
-- bind = $mainMod, J, layoutmsg, togglesplit
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Open browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- ── Focus Movement ────────────────────────────────────────────────────────────

-- Move focus with arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- ── Workspaces ────────────────────────────────────────────────────────────────

-- Switch to workspace N
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to workspace N
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Toggle scratchpad (special workspace)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Move active window to scratchpad
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ── Mouse Window Management ───────────────────────────────────────────────────

-- Drag to move a window
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Drag to resize a window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Audio ─────────────────────────────────────────────────────────────────────

-- Raise output volume (up to 200% via pamixer boost)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("pamixer --increase 5 --allow-boost 100 --set-limit 200"),
    { repeating = true }
)

-- Lower output volume
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("pamixer --decrease 5 --allow-boost 100"),
    { repeating = true }
)

-- Toggle output mute
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("pamixer --toggle-mute")
)

-- Toggle microphone mute
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
)

-- ── Media Playback ────────────────────────────────────────────────────────────

-- Skip to next track
hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true }
)

-- Toggle play / pause
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

-- Go to previous track
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)

-- ── Brightness ────────────────────────────────────────────────────────────────

-- Increase screen brightness
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { repeating = true }
)

-- Decrease screen brightness
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { repeating = true }
)

-- ── Screenshots ───────────────────────────────────────────────────────────────

-- Capture full screen → open in satty
hl.bind(
    "CTRL + Print",
    hl.dsp.exec_cmd("~/.config/screenshot/screenshot-satty.sh output")
)

-- Capture selected region → open in satty
hl.bind(
    mainMod .. " + Print",
    hl.dsp.exec_cmd("~/.config/screenshot/screenshot-satty.sh region")
)

-- Capture focused window → open in satty
hl.bind(
    "CTRL + SHIFT + Print",
    hl.dsp.exec_cmd("~/.config/screenshot/screenshot-satty.sh window")
)

-- ── Utilities ─────────────────────────────────────────────────────────────────

-- Pick a color from screen and copy hex to clipboard
hl.bind(
    "SUPER + SHIFT + C",
    hl.dsp.exec_cmd("hyprpicker | wl-copy")
)

-- Toggle swaync notification center
hl.bind(
    mainMod .. " + N",
    hl.dsp.exec_cmd("swaync-client -t")
)

-- Reload / relaunch waybar
hl.bind(
    mainMod .. " + SHIFT + W",
    hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh")
)

-- Open power menu (rofi)
hl.bind(
    "SUPER + X",
    hl.dsp.exec_cmd("~/.config/rofi/powermenu/powermenu.sh")
)

-- Lock the screen
hl.bind(
    "SUPER + L",
    hl.dsp.exec_cmd("$HOME/.config/hyprlock/scripts/hyprlock.sh")
)

-- Open clipboard history (copyq GUI)
hl.bind(
    "SUPER + V",
    hl.dsp.exec_cmd("copyq toggle")
)

-- Open wallpaper picker
hl.bind(
    mainMod .. " + SHIFT + T",
    hl.dsp.exec_cmd("~/.config/dotfiles/rofi/scripts/wallpaper.sh")
)

-- ── Window Switcher ───────────────────────────────────────────────────────────

-- Cycle to next window (Alt+Tab)
hl.bind(
    "ALT + Tab",
    hl.dsp.exec_cmd("snappy-switcher next")
)

-- Cycle to previous window (Alt+Shift+Tab)
hl.bind(
    "ALT + SHIFT + Tab",
    hl.dsp.exec_cmd("snappy-switcher prev")
)

hl.bind(
    "SUPER + E",
    hl.dsp.exec_cmd("omniglyph")
)

-- OCR
hl.bind(
    "SUPER + O",
    hl.dsp.exec_cmd("~/.config/dotfiles/hyprocr/rapidocr.sh")
)

hl.bind(
    "SUPER + SHIFT + O",
    hl.dsp.exec_cmd("~/.config/dotfiles/hyprocr/tsrocr.sh")
)
