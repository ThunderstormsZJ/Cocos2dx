--
-- Author: Thunder
-- Date: 2017-06-28 21:32:51
--

-- 需要在其他的文件中调用、不设置为local类型
local Heart = require("app.objects.Heart")
local AirShip = require("app.objects.AirShip")
local Bird = require("app.objects.Bird")

BackgroundLayer = class("BackgroundLayer", function()
	return display.newLayer()
end)

function BackgroundLayer:ctor()
	self.distanceBg = {}
	self.birds = {}

	self:createBackgrounds()

	self:addBody("heart", Heart)
	self:addBody("airship", AirShip)
	self:addBody("bird", Bird)

	self:createEdgeSegment()
end

function BackgroundLayer:createEdgeSegment()
	-- 创建不受重力约束的边界
	local width = self.map:getContentSize().width
	local skyHeight = self.map:getContentSize().height*9/10
	local groundHeight = self.map:getContentSize().height*3/16
	-- 上边界
	local sky = display.newNode()
	local bodyTop = cc.PhysicsBody:createEdgeSegment(cc.p(0, skyHeight), cc.p(width, skyHeight))
	sky:setPhysicsBody(bodyTop)
	self:addChild(sky)
	-- 下边界
	local ground = display.newNode()
	local bodyBottom = cc.PhysicsBody:createEdgeSegment(cc.p(0, groundHeight), cc.p(width, groundHeight))
	ground:setPhysicsBody(bodyBottom)
	self:addChild(ground)
end

function BackgroundLayer:addBody(objectGroupName, class)
	-- 从地图文件中获取对象
	local objects = self.map:getObjectGroup(objectGroupName):getObjects()
	for i=1, #objects, 1 do
		local dict = objects[i]

		if dict == nil then
			break
		end
		local sprite = class.new(dict["x"], dict["y"])
		self.map:addChild(sprite)

		if objectGroupName == "bird" then
			table.insert(self.birds, sprite)
		end
	end
end

function BackgroundLayer:addVelocityToBrid()
	local bird = nil
	for i=1,#self.birds do
		bird = self.birds[i]
		if bird == nil then
			break
		end

		local x = bird:getPositionX()
		if x <= display.width - self.map:getPositionX() then
			local birdBody = bird:getPhysicsBody()
			if birdBody:getVelocity().x == 0 then
				birdBody:setVelocity(cc.p(math.random(-70, -100), math.random(-40, 40)))	
			else
				table.remove(self.birds, i)		
			end
		end
	end
end

function BackgroundLayer:startGame()
	-- 帧事件；在Cocos2d-x中重载update函数
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.scroollBackgrouds))
	self:scheduleUpdate()
end

function BackgroundLayer:createBackgrounds()
	-- 创建幕布背景
	local bg = display.newSprite("images/bj1.jpg")
		:center()
		-- zorder 层级 -4位于最下一层
		:addTo(self, -4)

	-- 创建远景
	-- 两张图片拼接成远景背景图
	-- 锚点就是将该对象钉在的父级的原点位置
	local bg1 = display.newSprite("images/b2.png")
		:align(display.BOTTOM_LEFT, display.left, display.bottom+10)
		:addTo(self, -3)

	local bg2 = display.newSprite("images/b2.png")
		:align(display.BOTTOM_LEFT, display.left + bg1:getContentSize().width, display.bottom+10)
		:addTo(self, -3)

	table.insert(self.distanceBg, bg1)
	table.insert(self.distanceBg, bg2)

	-- 添加地图
	self.map = cc.TMXTiledMap:create("images/map.tmx")
		:align(display.BOTTOM_LEFT, display.left, display.bottom)
		:addTo(self, -1)
end

function BackgroundLayer:scroollBackgrouds(dt)
	-- 地图到了尽头就停止帧动画
	if self.map:getPositionX() <= display.width - self.map:getContentSize().width then
		self:unscheduleUpdate()
	end

	if self.distanceBg[2]:getPositionX() <= 0 then
		self.distanceBg[1]:setPositionX(0)
	end

	-- 远景的移动
	local x1 = self.distanceBg[1]:getPositionX() - 50*dt
	local x2 = x1+self.distanceBg[1]:getContentSize().width

	self.distanceBg[1]:setPositionX(x1)
	self.distanceBg[2]:setPositionX(x2)

	-- 地图的移动
	local x3 = self.map:getPositionX() - 130*dt
	self.map:setPositionX(x3)

	self:addVelocityToBrid()
end

return BackgroundLayer
