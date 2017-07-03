--
-- Author: Thunder
-- Date: 2017-06-27 22:27:40
--
require("app.layers.BackgroundLayer")
local Player = require("app.objects.Player")

local GameScene = class('GameScene', function()
	-- 构造物理世界场景
	return display.newPhysicsScene('GameScene')
end)


function GameScene:ctor()
	self.world = self:getPhysicsWorld()
	self.world:setGravity(cc.p(0, -98.0))
	-- 显示所有不可见的元素
	-- self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_JOINT)

	self.backgroundLayer = BackgroundLayer.new()
		:addTo(self)

	-- 创建主角
	self.player = Player.new()
		:setPosition(-20, display.height*2/3)
		:addTo(self)
	-- 飞入场景
	self:playerFlyToScene()

	-- 碰撞事件
	self:addCollision()
end

function GameScene:addCollision()
	local function contactLogic(node)

	end

	local function onContactBegin(contact)
		print("begin")
	end

	local function onContactSeperate(contact)
		print("seperate")
	end

	local contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	contactListener:registerScriptHandler(onContactSeperate, cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE)
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	eventDispatcher:addEventListenerWithFixedPriority(contactListener, 1)
end

function GameScene:playerFlyToScene()

	local function startDrop()
		self.player:getPhysicsBody():setGravityEnable(true)
		self.player:drop()
		self.backgroundLayer:startGame()
	end

	self.player:flying()

	local action = transition.sequence({
		cc.MoveTo:create(4, cc.p(display.cx, display.height*2/3)),
		cc.CallFunc:create(startDrop)
	})
	self.player:runAction(action)
end

function GameScene:onEnter()
	-- body
end

function GameScene:onExit( ... )
	-- body
end

return GameScene
