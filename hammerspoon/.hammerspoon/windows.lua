local window = require("hs.window")
local filter = require("hs.window.filter")
local screen = require("hs.screen")
local alert = require("hs.alert")
local LeftRightHotkey = require("LeftRightHotkey")

local module = {
    excludedApps = { "^$" },
    sort = filter.sortByFocusedLast,
    middleSplit = 50,
    window = {},
    layout = "tile",
    layouts = {
        tile = {
            matrix = {
                {
                    { 1, 1, 0, 0 }
                },
                {
                    -- two even vertical windows
                    { 1, -1, 0,  0 },
                    { 1, -1, -1, 0 }
                },
                {
                    -- main left window
                    { 1,     -1, 0,  0 },
                    -- two 50% vertical right windows
                    { 1 / 2, -1, -1, 0 },
                    { 1 / 2, -1, -1, 1 / 2 },
                },
                {
                    -- main left window
                    { 1,     -1, 0,  0 },
                    -- three 33% vertical right windows
                    { 1 / 3, -1, -1, 0 },
                    { 1 / 3, -1, -1, 1 / 3 },
                    { 1 / 3, -1, -1, 2 / 3 },
                },
                {
                    -- two left 50% windows
                    { 1 / 2, -1, 0,  0 },
                    { 1 / 2, -1, 0,  1 / 2 },
                    -- three right 33% vertical right windows
                    { 1 / 3, -1, -1, 0 },
                    { 1 / 3, -1, -1, 1 / 3 },
                    { 1 / 3, -1, -1, 2 / 3 },
                },
                {
                    -- three left 33% windows
                    { 1 / 3, -1, 0,  0 },
                    { 1 / 3, -1, 0,  1 / 3 },
                    { 1 / 3, -1, 0,  2 / 3 },
                    -- three right 33% vertical right windows
                    { 1 / 3, -1, -1, 0 },
                    { 1 / 3, -1, -1, 1 / 3 },
                    { 1 / 3, -1, -1, 2 / 3 },
                },

            },
        },
        maximized = {
            matrix = {
                {
                    { 1, 1, 0, 0 }
                }
            },
        }
    },
};

module.changeLayout = function(newLayout)
    module.layout = newLayout
    alert.show('Layout: ' .. module.layout)
    module.setLayout()
end

module.setLayout = function()
    local layout = module.layouts[module.layout]
    local matrix = layout.matrix[#module.windows] or layout.matrix[1]

    for i, v in pairs(matrix) do
        if v[2] < 0 then
            if v[3] == 0 then
                module.windows[i]:moveToUnit({ h = v[1], w = module.middleSplit / 100, x = 0, y = v[4] })
            else
                module.windows[i]:moveToUnit({
                    h = v[1],
                    w = 1 - (module.middleSplit / 100),
                    x = module.middleSplit / 100,
                    y = v[4]
                })
            end
        else
            module.windows[i]:moveToUnit({ h = v[1], w = v[2], x = v[3], y = v[4] })
        end
    end

    if layout.after then
        layout.after()
    end
end

module.getFocusedWindow = function()
    local focusedWindow = window.frontmostWindow()
    for i, win in ipairs(module.windows) do
        if win:id() == focusedWindow:id() then
            return {
                window = win,
                index = i
            }
        end
    end
    return nil
end

module.getWindowIndex = function(win)
    for i, w in ipairs(module.windows) do
        if w:id() == win:id() then
            return i
        end
    end
    return nil
end

module.keybindings = {
    {
        { "lctrl", "lcmd" },
        "return",
        function()
            if module.layout == "maximized" then
                module.changeLayout("tile")
            else
                module.changeLayout("maximized")
            end
        end
    },
    {
        { "lctrl", "lcmd" },
        "l",
        function()
            if module.layout == "maximized" then return end
            module.middleSplit = module.middleSplit + 5
            module.setLayout()
            alert.show(module.middleSplit .. "% split")
        end
    },
    {
        { "lctrl", "lcmd" },
        "h",
        function()
            if module.layout == "maximized" then return end
            module.middleSplit = module.middleSplit - 5
            module.setLayout()
            alert.show(module.middleSplit .. "% split")
        end
    },
    {
        { "lctrl", "lcmd" },
        "j",
        function()
            if module.layout == "maximized" then return end
            local focusedWindow = module.getFocusedWindow()
            if focusedWindow then
                local nextWindow = module.windows[focusedWindow.index + 1] or module.windows[1]
                nextWindow:focus()
            end
        end
    },
    {
        { "lctrl", "lcmd" },
        "k",
        function()
            if module.layout == "maximized" then return end
            local focusedWindow = module.getFocusedWindow()
            if focusedWindow then
                local nextWindow = module.windows[focusedWindow.index - 1] or module.windows[#module.windows]
                nextWindow:focus()
            end
        end
    },
    {
        { "lctrl", "lcmd" },
        "s",
        function()
            if module.layout == "maximized" then return end
            local focusedWindow = module.getFocusedWindow()
            if focusedWindow then
                table.remove(module.windows, focusedWindow.index)
                table.insert(module.windows, 1, focusedWindow.window)
                module.setLayout()
                module.windows[1]:focus()
            end
        end
    },
    {
        { "lctrl", "lcmd" },
        "f",
        function()
            if module.layout == "maximized" then return end
            local frontWindow = window.frontmostWindow()
            if frontWindow then
                frontWindow:focus()
            end
        end
    },
}

module.onEvent = function()
    module.windows = module.filter:getWindows()
    module.setLayout()
end

module.start = function()
    module.filter = window.filter.new()
        :setDefaultFilter()
        :setOverrideFilter({
            visible      = true,
            fullscreen   = false,
            currentSpace = true,
            rejectTitles = module.excludedApps,
            allowRoles   = { 'AXStandardWindow' },
        })
        :setSortOrder(module.sort)
        :subscribe(
            { 'windowMoved', 'windowMinimized', 'windowUnminimized', 'windowsChanged' },
            module.onEvent)

    module.filter.screenWatcher = screen.watcher.new(module.onEvent):start()
    module.windows = module.filter:getWindows()
    module.setLayout()

    for _, key in ipairs(module.keybindings) do
        LeftRightHotkey.bind(key[1], key[2], function() key[3]() end)
    end
end

module.stop = function()
    module.filter:unsubscribeAll()
    module.filter.screenWatcher:stop()
end

return module