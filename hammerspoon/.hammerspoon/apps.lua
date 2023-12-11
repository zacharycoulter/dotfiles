local application = require("hs.application")
local LeftRightHotkey = require("LeftRightHotkey")

application.enableSpotlightForNameSearches(true)

local module = {
    mappings = {
        F = 'Finder',
        W = 'WezTerm',
        --B = 'qutebrowser',
        A = 'Arc',
        D = 'DataGrip',
        S = 'Slack',
        T = 'Trello',
        Z = 'Zoom',
        C = 'Calendar',
        E = 'Mail',
        M = 'Music',
    }
}

module.start = function()
    for key, appName in pairs(module.mappings) do
        LeftRightHotkey.bind({ 'rOption' }, key, function()
            local app = application.get(appName)
            if not app or app:isHidden() then
                application.launchOrFocus(appName)
            else
                app:hide()
            end
        end)
    end
end

module.stop = function()

end

return module
