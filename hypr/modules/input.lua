hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0.5,

        touchpad = {
            natural_scroll = true,
        },
    },

    gestures = {
        gesture = {
            "3, horizontal, workspace",
        },
    },

    device = {
        {
            name = "epic-mouse-v1",
            sensitivity = -0.5,
        },
        {
            name = "asup1204:00-093a:2642-touchpad", -- Laptop touch pad
            enabled = true,
        },
        {
            name = "2.4g-receiver-mouse",
            sensitivity = -0.3,
            accel_profile = "flat",
        },
    },
})
