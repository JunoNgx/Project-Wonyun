Dust = Class {}

function Dust:init()

	self.baseid = 'dust'
	self.typeid = 'dust'
	self.objType = 'decorTop'

	self.x = 0
	self.y = 0
	self.r = 0
	self.scale = 1
	-- self.velo = {x = 0, y = 0}

	self.exists = false
	self.fadeSpd = 0

	self.col = {70,70,70}
	self.gfx = gfx_dust
end

function Dust:update(dt)
	if self.exists then
		-- updateVelocity(self, dt)

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

function Dust:spawn(x, y, r, variance)
	self.scale = love.math.random(10, 15) / 10

	self.x = x + love.math.random(-variance, variance)
	self.y = y + love.math.random(-variance, variance)
	self.r = r

	-- self.velo.x = 10 * math.cos(r)
	-- self.velo.y = 10 * math.sin(r)
	local col = love.math.random(60,70)
	self.col = {col,col,col, 240}
	self.fadeSpd = love.math.random(V.d_fadingSpeedMin, V.d_fadingSpeedMax)

	self.exists = true
end

function Dust:kill()
	self.exists = false
end