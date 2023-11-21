local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.font =
    wezterm.font('SFMono Nerd Font', { weight = 'Medium' })
config.font_size = 14

config.enable_tab_bar = false

config.background = {
    -- {
    --     source = {
    --         File = "/Users/zacharycoulter/Sonoma.png",
    --     },
    --     height = 'Cover',
    --     width = 'Cover',
    --     repeat_x = 'NoRepeat',
    --     repeat_y = 'NoRepeat',
    --     vertical_align = 'Middle',
    --     horizontal_align = 'Center',
    -- },
    {
        source = {
            Color = "#000"
        },
        width = '100%',
        height = '100%',
    },
}

config.window_decorations = "RESIZE"

config.window_padding = {
    top = 12,
    bottom = 12,
    left = 16,
    right = 16
}

config.window_close_confirmation = "NeverPrompt"

config.disable_default_key_bindings = true
config.keys = {
    {
        key = 'k',
        mods = 'CMD',
        action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = wezterm.action.ScrollByPage(-1),
    },
    {
        key = 'j',
        mods = 'CTRL',
        action = wezterm.action.ScrollByPage(1),
    },
    {
        key = 'c',
        mods = 'CMD',
        action = wezterm.action.CopyTo 'Clipboard',
    },
    {
        key = 'v',
        mods = 'CMD',
        action = wezterm.action.PasteFrom 'Clipboard'
    },
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'q',
        mods = 'CMD',
        action = wezterm.action.QuitApplication,
    },
}

return config
