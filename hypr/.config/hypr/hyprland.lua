-- Converted from hyprland.conf
-- See https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-2",
    mode     = "3440x1440@144",
    position = "0x0",
    scale    = 1,
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- NVIDIA Settings (Optimized for RTX 4080)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VR_ALLOWED", "0")

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "28")

-----------------------
---- CURSOR ----
-----------------------

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("openrgb -p gg")
end)

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "adaptive",
    },

    master = {
        new_on_top = true,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            inactive_border = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
        },

        layout = "dwindle",
        resize_on_border = true,
    },

    group = {
        col = {
            border_active          = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            border_inactive        = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
            border_locked_active   = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            border_locked_inactive = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
        },
    },

    decoration = {
        rounding = 10,
        active_opacity   = 0.8, -- Provides the base transparency for blur
        inactive_opacity = 0.7,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = true,
            noise = 0.01,
            contrast = 1.2,
            brightness = 1.1,
            vibrancy = 0.3,
        },
    },

    misc = {
        always_follow_on_dnd = true,
    },
})

----------------
---- LAYERS ----
----------------

-- Layer Rules (Wofi and Menus)
hl.layer_rule({ match = { namespace = "^(wofi)$" }, blur = true })
hl.layer_rule({ match = { namespace = "^(wofi)$" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "^(wofi)$" }, animation = "layersIn" })
hl.layer_rule({ match = { namespace = "^(wofi)$" }, animation = "layersOut" })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "move-kitty",
    match = { class = "kitty" },

    move      = "100 100",
    animation = "popin",
})

hl.window_rule({
    name  = "emulator-float",
    match = { class = "^(Emulator)$" },

    float  = true,
    center = true,
})

-- MASTER RULE (Optional):
-- Uncomment below if you want EVERYTHING with transparency to have blur automatically:
-- hl.window_rule({ name = "blur-all", match = { class = ".*" }, blur = true })

-------------------
---- ANIMATIONS ----
-------------------

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("wind",  { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 },  { 0.1, 1.1 } } })
hl.curve("winOut",{ type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 },      { 1, 1 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner",  style = "once" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind" })

-----------------
---- LAYOUTS ----
-----------------

hl.config({
    dwindle = {
        force_split = 2,               -- new window always bottom/right
        split_width_multiplier = 3.0,  -- on ultrawide, split top/bottom instead of side by side
        preserve_split = true,
    },
})

------------------------------
---- SCROLLOVERVIEW PLUGIN ----
------------------------------

hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 300,
            scale = 0.5,
            workspace_gap = 100,
            layout = "vertical",
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("wofi --show drun"))

-- Focus and Movement
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Apps and Utilities
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Window Management
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + TAB", hl.plugin.scrolloverview.overview("toggle"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- Drag floating window with SUPER + Left Click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize floating window with SUPER + Right Click

-- Toggle split direction (vertical <-> horizontal)
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
