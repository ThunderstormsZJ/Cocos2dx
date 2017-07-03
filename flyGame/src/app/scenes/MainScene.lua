local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	-- cx\cy:設計分辨率中央的xy坐標
  	display.newSprite("images/main.jpg")
  		:center()
  		:addTo(self)

  	local bird = display.newSprite("images/title.png")
  		:pos(display.cx*2/3, display.cy)
  		:addTo(self)

  	-- 0.5秒的時候向上向下分別移動10個像素
  	local move1 = cc.MoveBy:create(0.5, cc.p(0, 10))
  	local move2 = cc.MoveBy:create(0.5, cc.p(0, -10))

  	local SequenceAction = cc.Sequence:create(move1, move2)
  	transition.execute(bird, cc.RepeatForever:create(SequenceAction))

  	-- quick有三種按鈕:UIPushButton/UICheckBoxButton/UICheckBoxButtonGroup
  	cc.ui.UIPushButton.new({normal="images/start1.png", pressed="images/start2.png"})
  		:pos(display.cx*3/2, display.cy*2/3)
  		:onButtonClicked(function()
  			printInfo("Start Game")
  			app:enterScene("GameScene", nil, "slideInB", 1)
  		end)
  		:addTo(self)
end

function MainScene:onEnter()
	printInfo("OnEnter")
end

function MainScene:onExit()
	printInfo("OnExit")
end

return MainScene
