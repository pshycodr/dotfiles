-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/

-- "Smart gaps" / "No gaps when only"
--
-- Uncomment all if you wish to use that.

-- hl.workspace_rule({
--     workspace = "w[tv1]",
--     gaps_out = 0,
--     gaps_in = 0,
-- })
--
-- hl.workspace_rule({
--     workspace = "f[1]",
--     gaps_out = 0,
--     gaps_in = 0,
-- })
--
-- hl.window_rule({
--     name = "no-gaps-wtv1",
--     match = {
--         float = false,
--         workspace = "w[tv1]",
--     },
--     border_size = 0,
--     rounding = 0,
-- })
--
-- hl.window_rule({
--     name = "no-gaps-f1",
--     match = {
--         float = false,
--         workspace = "f[1]",
--     },
--     border_size = 0,
--     rounding = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more

hl.config({
    dwindle = {
        -- pseudotile = true,
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more

hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})
