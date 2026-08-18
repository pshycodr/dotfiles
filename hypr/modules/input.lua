hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = -0.5,

        touchpad = {
            natural_scroll = true,
        },
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "asup1204:00-093a:2642-touchpad",
    enabled = true,
    sensitivity = 0.5,
})

hl.device({
    name = "2.4g-receiver-mouse",
    sensitivity = -0.5,
    accel_profile = "adaptive",
})

