Explosion = Class {}

function spawnExplosion(x, y, variance, nummer, isBig)
	local isBig = isBig or false
	local nummer = nummer or 1

	for i = 1, nummer do
		local explosion = Pool.explosion[i]
		explosion:spawn(x, y, variance)

		table.insert(Assistant.t2, explosion)
		table.remove(Pool.explosion, 1)
	end

	if isBig then
		local nummer = love.math.random(2,5)
		for i = 1, nummer do
			spawnFragment(M.getX(), M.getY(), love.math.random(math.pi*2), true)
		end
	end

	-- camera:shake()
end

-- function spawnBigExplosion(x, y, variance, nummer)
-- 	local nummer = nummer or 1

-- 	for i = 1, nummer do
-- 		local explosion = Pool.explosion[i]
-- 		explosion:spawn(x, y, variance)

-- 		table.insert(Assistant.t2, explosion)
-- 		table.remove(Pool.explosion, 1)
-- 	end

-- 	local nummer = love.math.random(2,5)
-- 	for i = 1, nummer do
-- 		spawnFragment(M.getX(), M.getY(), love.math.random(math.pi*2), true)
-- 	end

-- end

function Explosion:init()

	self.baseid = 'explosion'
	self.typeid = 'explosion'
	self.objType = 'decorTop'

	self.x = 0
	self.y = 0
	self.scale = 0
	-- self.r = love.math.random(0,4) * math.pi
	self.lifetime = 0

	self.exists = false

	self.currentFrame = 1
	self.gfx = gfx_explosion[1]
end

function Explosion:update(dt)
	if self.exists then
		self.lifetime = self.lifetime + dt

		-- Run the animation and dies when the animation ends
		self.currentFrame = math.floor(self.lifetime / V.e_frameRate ) + 1
		if gfx_explosion[self.currentFrame] == nil then 
			self:kill()
		else 
			self.gfx = gfx_explosion[self.currentFrame]
		end

	end
end

function Explosion:draw()
	love.graphics.setColor(240,120,120)
	Jutils.draw(self.gfx, self.x, self.y, self.r, self.scale, self.scale)

	if G.debugMode then
		love.graphics.setColor(255,255,255)
		love.graphics.print(self.currentFrame, self.x + 24, self.y)
		love.graphics.print(self.lifetime, self.x + 24, self.y - 16)
	end
end

function Explosion:kill()
	self.exists = false
end

function Explosion:spawn(x, y, variance)
	local variance = variance or 0

	self.x = x + love.math.random(-variance, variance)
	self.y = y + love.math.random(-variance, variance)

	self.scale = love.math.random(5,8)/10
	self.r = love.math.random(0,4) * math.pi
	self.lifetime = 0

	self.exists = true
	-- self.currentFrame = 1
	-- self.gfx = gfx_explosion[1]
end