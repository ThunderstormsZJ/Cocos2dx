
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
	math.randomseed(os.time())
    cc.FileUtils:getInstance():addSearchPath("res/")
    -- 資源圖寬度/設計分辨率寬度:保證在能顯示完整的寬度
    cc.Director:getInstance():setContentScaleFactor(640/CONFIG_SCREEN_HEIGHT)
    display.addSpriteFrames("images/player.plist", "images/player.pvr.ccz")
    self:enterScene("MainScene")
end

return MyApp
