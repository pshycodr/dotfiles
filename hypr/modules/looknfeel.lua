
-- ── General ───────────────────────────────────────────────────────────────────

hl.config({
    general = {
        gaps_in = 7,
        gaps_out = 14,

        border_size = 1,

        -- Near-invisible borders — let content and shadow define the window edge
        -- col = {
        --     active_border = "rgba(99d4a2ee)",
        --     inactive_border = "rgba(414941aa)",
        -- },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    -- ── Decoration ────────────────────────────────────────────────────────────

    decoration = {
        -- screen_shader = "~/.config/hypr/shaders/grayscale.frag",

        rounding = 8,
        rounding_power = 3,

        active_opacity = 1.0,
        inactive_opacity = 0.96,

        dim_inactive = true,
        dim_strength = 0.10,

        shadow = {
            enabled = true,
            range = 25,
            render_power = 3,
            offset = "0 5",
            color = "rgba(00000045)",
            color_inactive = "rgba(00000022)",
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            noise = 0.03,
            contrast = 1.05,
            brightness = 1.0,
            vibrancy = 0.0,
            ignore_opacity = true,
            new_optimizations = true,
            popups = true,
            popups_ignorealpha = 0.2,
            special = false,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        -- vfr = true,
        vrr = 0,
        focus_on_activate = true,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

-- ── Animations ────────────────────────────────────────────────────────────────

-- ── Bezier curves ────────────────────────────────────────────────────────────

-- lens → weighted, smooth settle — window entering the frame
hl.curve("lens", {
    type = "bezier",
    points = {
        { 0.22, 1.0 },
        { 0.36, 1.0 },
    },
})

-- push → fast ease-out — scene pushing forward
hl.curve("push", {
    type = "bezier",
    points = {
        { 0.25, 1.0 },
        { 0.5, 1.0 },
    },
})

-- pull → hard acceleration out — fast cut away
hl.curve("pull", {
    type = "bezier",
    points = {
        { 0.6, 0.0 },
        { 0.8, 0.45 },
    },
})

-- cut → near-linear, minimal easing — instant feel for fades
hl.curve("cut", {
    type = "bezier",
    points = {
        { 0.4, 0.0 },
        { 0.6, 1.0 },
    },
})

-- ── Windows ──────────────────────────────────────────────────────────────────

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 3,
    bezier = "push",
    style = "slide",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4,
    bezier = "lens",
    style = "popin 90%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "pull",
    style = "popin 90%",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "push",
})

-- ── Borders ──────────────────────────────────────────────────────────────────

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5,
    bezier = "push",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 50,
    bezier = "push",
    style = "loop",
})

-- ── Fades ────────────────────────────────────────────────────────────────────

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3,
    bezier = "cut",
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 3,
    bezier = "lens",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 2,
    bezier = "pull",
})

-- ── Layers ────────────────────────────────────────────────────────────────────

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3,
    bezier = "push",
    style = "slide",
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 3,
    bezier = "lens",
    style = "slide",
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 2,
    bezier = "pull",
    style = "slide",
})

-- ── Workspaces ───────────────────────────────────────────────────────────────

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "push",
    style = "slide",
})

hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 4,
    bezier = "lens",
    style = "slide",
})

hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 3,
    bezier = "pull",
    style = "slide",
})

-- ── Zoom ─────────────────────────────────────────────────────────────────────

hl.animation({
    leaf = "zoomFactor",
    enabled = true,
    speed = 4,
    bezier = "lens",
})
