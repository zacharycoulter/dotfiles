local application = require("hs.application")
local LeftRightHotkey = require("LeftRightHotkey")

application.enableSpotlightForNameSearches(true)

local module = {
    mappings = {
        F = 'Finder',
        W = 'WezTerm',
        B = 'qutebrowser',
        D = 'DataGrip',
        S = 'Slack',
        T = 'Todoist',
        Z = 'Zoom',
        C = 'Calendar',
        M = 'Mail'
    }
}

module.start = function()
    for key, appName in pairs(module.mappings) do
        LeftRightHotkey.bind({ 'rOption' }, key, function()
            local app = application.get(appName)
            if app and app:mainWindow() and app:mainWindow():isMinimized() == false then
                app:mainWindow():minimize()
            else
                application.launchOrFocus(appName)
            end
        end)
    end
end

module.stop = function()

end

return module
