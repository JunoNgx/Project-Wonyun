Explosion = Class {}

function spawnExplosion(x, y, colorCode, scaleSize)
	-- local isBig = isBig or false
	-- local isPlayer = isPlayer or false
	-- local nummer = nummer or 1

	-- for i = 1, nummer do
	-- 	local explosion = Pool.explosion[i]
	-- 	explosion:spawn(x, y, colorCode, scaleSize)

	-- 	table.insert(Assistant.t2, explosion)
	-- 	table.remove(Pool.explosion, 1)
	-- end

	local explosion = Pool.explosion[1]
	explosion:spawn(x, y, colorCode, scaleSize)

	-- If big explosion then spawn fragments as well
	if scaleSize == 3 then
		local nummer = love.math.random(2,5)
		for i = 1, nummer do
			spawnFragment(x, y, love.math.random(math.pi*2), colorCode)
			-- if colorCode == 3 then -- Player's death
			-- 	spawnFragment(x, y, love.math.random(math.pi*2), true)
			-- elseif colorCode == 2 then -- Enemy death
			--     spawnFragment(x, y, love.math.random(math.pi*2))
			-- end
		end
	end

	table.insert(Assistant.t2, explosion)
	table.remove(Pool.explosion, 1)

	-- Shake screen according to explosion size
	if scaleSize == 1 then
		-- Camera:shake(5, 0.2)
	elseif scaleSize == 2 then
		Camera:shake(4, 0.2)
	elseif scaleSize == 3 then
		Camera:shake(7, 0.2)
	end

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
	self.col = 0
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
	love.graphics.setColor(self.col)
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

function Explosion:spawn(x, y, colorCode, scaleSize)
	self.x = x
	self.y = y

	if colorCode == 1 then -- Blue
		self.col = {50 ,  80, 150, 255}
	elseif colorCode == 2 then -- Red
		self.col = {240, 120, 120, 255}
	elseif colorCode == 3 then -- White
		self.col = {220, 220, 220, 255}
	end

	if scaleSize == 1 then
		self.scale = 0.2
	elseif scaleSize == 2 then
		self.scale = love.math.random(5,8)/10
	elseif scaleSize == 3 then
		self.scale = love.math.random(10,12)/10
	end
	
	self.r = love.math.random(0,4) * math.pi
	self.lifetime = 0

	self.exists = true
	-- self.currentFrame = 1
	-- self.gfx = gfx_explosion[1]
end