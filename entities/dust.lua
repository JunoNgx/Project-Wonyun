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

	self.gfx = gfx_dust
end

function Dust:update(dt)
	if self.exists then
		-- updateVelocity(self, dt)

		if self.scale > 0.1 then
			self.scale = self.scale - V.d_fadingSpeed * dt
		else
			self:kill()
		end
	end
end

function Dust:draw()
	love.graphics.setColor(70,70,70)
	Jutils.draw(self.gfx, self.x, self.y, 0, self.scale, self.scale)
end

function Dust:spawn(x, y, r, variance)
	self.scale = love.math.random(10, 15) / 10

	self.x = x + love.math.random(-variance, variance)
	self.y = y + love.math.random(-variance, variance)
	self.r = r

	-- self.velo.x = 10 * math.cos(r)
	-- self.velo.y = 10 * math.sin(r)

	self.exists = true
end

function Dust:kill()
	self.exists = false
end