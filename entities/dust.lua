Dust = Class {}

function spawnDust(x, y, r, variance, colorCode)
	local dust = Pool.dust[1]
	local variance = variance or 0

	dust:spawn(x, y, r, variance, colorCode)

	table.insert(Assistant.t1, dust)
	table.remove(Pool.dust, 1)
end

function Dust:init()

	self.baseid = 'dust'
	self.typeid = 'dust'
	self.objType = 'decorTop'

	self.x = 0
	self.y = 0
	self.r = 0
	self.scale = 1
	self.velo = {x = 0, y = 0}

	self.exists = false
	self.fadeSpd = 0

	self.col = {70,70,70}
	self.gfx = gfx_dust
end

function Dust:update(dt)
	if self.exists then
		updateVelocity(self, dt)

		if self.scale > 0.1 then
			-- self.scale = self.scale - V.d_fadingSpeed * dt
			self.scale = self.scale - self.fadeSpd * dt
		else
			self:kill()
		end
	end
end

function Dust:draw()
	love.graphics.setColor(self.col)
	Jutils.draw(self.gfx, self.x, self.y, 0, self.scale, self.scale)
end

function Dust:spawn(x, y, r, variance, colorCode)
	self.scale = love.math.random(7, 10) / 10

	self.x = x + love.math.random(-variance, variance)
	self.y = y + love.math.random(-variance, variance)
	self.r = r

	self.velo.x = V.d_velo * math.cos(r)
	self.velo.y = V.d_velo * math.sin(r)

	-- Change color if smoke is from a hostile explosion
	if colorCode == 1 then -- Arsenic Blue
		local diff = love.math.random(-10,10)
		self.col = {59 + diff, 68 + diff, 75 + diff, 240}
	elseif colorCode == 2 then -- Red
		local diff = love.math.random(-40,-10)
		self.col = {240 + diff, 120 + diff, 120 + diff, 240}
	elseif colorCode == 3 then -- Grey
		local diff = love.math.random(-40,-10)
		self.col = {110 + diff, 110 + diff, 110 + diff, 240}
	end

	self.fadeSpd = love.math.random(V.d_fadingSpeedMin, V.d_fadingSpeedMax)

	self.exists = true
end

function Dust:kill()
	self.exists = false
end