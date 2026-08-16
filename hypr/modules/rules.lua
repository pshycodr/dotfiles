hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run",
    },
    move = "20 monitor_h-120",
    float = true,
})

hl.layer_rule({
    match = {
        namespace = "swaync-control-center",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "swaync-control-center",
    },
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = {
        namespace = "swaync-notification-window",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "swaync-notification-window",
    },
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = {
        namespace = "rofi",
    },
    animation = "popin 90%",
})

hl.layer_rule({
    match = {
        namespace = "rofi",
    },
    dim_around = true,
})

hl.layer_rule({
    match = {
        namespace = "waybar",
    },
    no_anim = true,
})
