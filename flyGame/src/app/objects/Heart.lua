--
-- Author: Thunder
-- Date: 2017-06-29 21:41:55
--
-- 心形
local Heart = class("Heart", function()
	return display.newSprite("images/heart.png")
end)

local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.0, 0.0, 0.0)

function Heart:ctor(x, y)
	local heartBody = cc.PhysicsBody:createCircle(self:getContentSize().width/2, MATERIAL_DEFAULT)
	-- 物体会固定不动
	heartBody:setDynamic(false)

	heartBody:setCategoryBitmask(0x0001)
	heartBody:setContactTestBitmask(0x0100)
	heartBody:setCollisionBitmask(0x0001)

	self:setPhysicsBody(heartBody)
	self:getPhysicsBody():setGravityEnable(false)
	self:setPosition(x, y)
	self:setTag(HEART_TAG)
end

return Heart
