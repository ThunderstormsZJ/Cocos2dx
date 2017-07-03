--
-- Author: Thunder
-- Date: 2017-07-01 18:29:10
--
-- 飞艇
local AirShip = class("AirShip", function()
	return display.newSprite("#airship.png")
end)

local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.0, 0.0, 0.0)

function AirShip:ctor(x, y)
	local airshipSize = self:getContentSize()
	local airshipBody = cc.PhysicsBody:createCircle(airshipSize.width/2, MATERIAL_DEFAULT)

	self:setPhysicsBody(airshipBody)
	self:getPhysicsBody():setGravityEnable(false)
	self:setPosition(x, y)

	-- 上下移动的动画
	local moveUp = cc.MoveBy:create(3, cc.p(0, airshipSize.height / 2 ))
	local moveDown = cc.MoveBy:create(3, cc.p(0, -airshipSize.height / 2 ))
	local sequenceAction = cc.Sequence:create(moveUp, moveDown)
	transition.execute(self, cc.RepeatForever:create(sequenceAction))
end

return AirShip