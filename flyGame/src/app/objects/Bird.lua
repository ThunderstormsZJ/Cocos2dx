--
-- Author: Thunder
-- Date: 2017-07-01 19:12:18
--

local Bird = class("Bird", function()
	return display.newSprite("#bird1.png")
end)

local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.0, 0.0, 0.0)

function Bird:ctor(x, y)
	local birdSize = self:getContentSize()
	local birdBody = cc.PhysicsBody:createCircle(birdSize.width/2, MATERIAL_DEFAULT)

	self:setPhysicsBody(birdBody)
	self:getPhysicsBody():setGravityEnable(false)
	self:setPosition(x, y)

	self:flying()
end

function Bird:flying()
	local frames = display.newFrames("bird%d.png", 1, 9)
	local animation = display.newAnimation(frames, 0.5/9)
	animation:setDelayPerUnit(0.1)
	self:playAnimationForever(animation)
end

return Bird