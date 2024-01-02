local wezterm = require("wezterm")

return {
    color_scheme = "Catppuccin Mocha",
    font = wezterm.font("SFMono Nerd Font", { weight = "Medium" }),
    font_size = 14,
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    background = {
        {
            source = {
                Color = "#12121c",
            },
            width = "100%",
            height = "100%",
            opacity = 0.9,
        },
    },
    window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    },
    window_background_opacity = 0.9,
    win32_system_backdrop = "Acrylic",
    macos_window_background_blur = 8,
    window_close_confirmation = "NeverPrompt",
    disable_default_key_bindings = true,
    keys = {
        { key = "l", mods = "CMD", action = wezterm.action.ShowLauncher },
        {
            key = "k",
            mods = "CMD",
            action = wezterm.action({ SendString = "clear\n" }),
        },
        {
            key = "k",
            mods = "CTRL",
            action = wezterm.action.ScrollByPage(-1),
        },
        {
            key = "j",
            mods = "CTRL",
            action = wezterm.action.ScrollByPage(1),
        },
        {
            key = "c",
            mods = "CMD",
            action = wezterm.action.CopyTo("Clipboard"),
        },
        {
            key = "v",
            mods = "CMD",
            action = wezterm.action.PasteFrom("Clipboard"),
        },
        {
            key = "w",
            mods = "CMD",
            action = wezterm.action.CloseCurrentPane({ confirm = false }),
        },
        {
            key = "q",
            mods = "CMD",
            action = wezterm.action.QuitApplication,
        },
        {
            key = "e",
            mods = "CMD",
            action = wezterm.action.SendString("nvim\n"),
        },
        {
            key = "z",
            mods = "CMD",
            action = wezterm.action({ SendString = "fzf\n" }),
        },
        {
            key = "a",
            mods = "CMD",
            action = wezterm.action({ SendString = "tmux a\n" }),
        },
        {
            key = "t",
            mods = "CMD",
            action = wezterm.action({ SendString = "\ntmux new -s ${PWD##*/}\n" }),
        },
        {
            key = "h",
            mods = "CMD",
            action = wezterm.action.Hide,
        },
    },
}
