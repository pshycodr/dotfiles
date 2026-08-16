-- ###################
-- ### PERMISSIONS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Permissions/

-- Permission changes here require a Hyprland restart.
-- They are not applied on-the-fly for security reasons.

-- hl.config({
--     ecosystem = {
--         enforce_permissions = 1,
--     },
-- })

-- hl.permission({
--     path = "/usr/(bin|local/bin)/grim",
--     permission = "screencopy",
--     mode = "allow",
-- })

-- hl.permission({
--     path = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
--     permission = "screencopy",
--     mode = "allow",
-- })

-- hl.permission({
--     path = "/usr/(bin|local/bin)/hyprpm",
--     permission = "plugin",
--     mode = "allow",
-- })
