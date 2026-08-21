hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment && systemctl --user start waybar.service")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")

    hl.exec_cmd("ghostty")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,

        col = {
            inactive_border = "rgba(563a60ff)",
            active_border = { colors = { "rgba(f2b7ffff)", "rgba(a488f6ff)" }, angle = 45 },
        },
    },

    decoration = {
        rounding = 10,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(0e0216ff)",
        },
    },

    animations = {
        enabled = false,
    },

    input = {
        kb_options = "ctrl:nocaps",
        sensitivity = -0.4,
        follow_mouse = 1,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = "rgba(0e0216ff)",
    },

    cursor = {
        no_hardware_cursors = false,
        inactive_timeout = 3,
        hide_on_key_press = true,
        hide_on_touch = true,
        hide_on_tablet = true,
    },
})

hl.bind("CTRL + ALT + delete", hl.dsp.exit())
hl.bind("SUPER + escape", hl.dsp.exec_cmd("systemctl suspend")) -- && hyprlock
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("wofi --show drun"), { release = true })
hl.bind("SUPER + tab", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox"))

hl.bind("ALT + h", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + l", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + j", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + k", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + l", hl.dsp.window.move({ direction = "right" }))

local wsKeys = { "u", "i", "o", "p" }
for idx, key in ipairs(wsKeys) do
    hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = idx }))
    hl.bind("ALT + SHIFT + " .. key, hl.dsp.focus({ workspace = idx + 4 }))
    hl.bind("SUPER + " .. key, hl.dsp.window.move({ workspace = idx }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = idx + 4 }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

require("hyprland-monitors")



