--
-- Author: Thunder
-- Date: 2017-06-29 20:02:31
--
-- 主角
local Player = class("Player", function()
	return display.newSprite("#flying1.png")
end)

function Player:ctor()
	self:addAnimationCache()
	-- 给角色添加物理特性
	-- 参数1：表示矩形box的大小
	-- 参数2：表示对象物理材质的属性(可以通过cc.PhysicsMaterial(density, restitution, friction)自定义)
	-- 参数3：表示body与中心的偏移量
	local body = cc.PhysicsBody:createBox(self:getContentSize(), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0,0))

	body:setCategoryBitmask(0x0111)
	body:setContactTestBitmask(0x1111)
	body:setCollisionBitmask(0x1001)

	self:setPhysicsBody(body)
	self:getPhysicsBody():setGravityEnable(false)
	self:setTag(PLAYER_TAG)
end

function Player:addAnimationCache()
	-- 将飞行/下落/死亡动画加入到缓存当中
	local animations = {"flying", "drop", "die"}
	local animationFrameNum = {4, 3, 4}

	for i=1, #animations do
		local frame = display.newFrames(animations[i] .. "%d.png", 1, animationFrameNum[i])

		local animation = display.newAnimation(frame, 0.3/4)

		display.setAnimationCache(animations[i], animation)
	end
end

function Player:flying()
	transition.stopTarget(self)
	transition.playAnimationForever(self, display.getAnimationCache("flying"))
end

function Player:drop()
	transition.stopTarget(self)
	transition.playAnimationForever(self, display.getAnimationCache("drop"))
end

function Player:die()
	transition.stopTarget(self)
	transition.playAnimationForever(self, display.getAnimationCache("die"))
end

return Player
