local alert = require("hs.alert")

local LeftRightHotkey = require("LeftRightHotkey")

require("apps").start()
require("windows").start()
require('mouse')('cmd', 'm')

-- General config
LeftRightHotkey.bind({ 'lCmd', 'lCtrl' }, 'r', function() hs.reload() end)
LeftRightHotkey.start()
alert.show('Hammerspoon loaded')
