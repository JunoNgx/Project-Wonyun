Star = Class {}

function Star:init()

	self.baseid = 'star'
	self.typeid = 'star'
	self.objType = 'decorBack'

	self.x = 0
	self.y = 0

	self.scale = 1
	self.velo = {x = 0, y = 0}
	-- self.alive = false
	self.exists = false

	-- self.gfx = gfx_star
end

function Star:update(dt)
	updateVelocity(self, dt)

	if outOfBounds(self) then self:reset() end
end

function Star:draw()
	if not G.hallucinativeMode then
		love.graphics.setColor(250, 72, 4, 255)
	else
		love.graphics.setColor(24, 170, 120, 255)
	end
	Jutils.draw(self.gfx, self.x, self.y, 0, self.scale, self.scale)

	if G.debugMode then
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255,255,255,170)
		love.graphics.print(self.velo.y, self.x + 16, self.y)
		love.graphics.print(self.scale, self.x + 16, self.y + 16)
	end
end

function Star:reset()
	local randomizer = love.math.random(4,12)/10

	self.x = love.math.random(V.margin_rtlt, gRes.w + V.margin_rtlt)
	self.y = -100

	self.scale = randomizer
	self.velo.y = randomizer * V.s_veloY

	-- self.alive = true
	self.exists = true
	self.gfx = gfx_star[love.math.random(1,2)]
end

function Star:spread()
	self.x = love.math.random(-V.margin_rtlt, gRes.w + V.margin_rtlt)
	self.y = love.math.random(-V.margin_rtlt, gRes.h + V.margin_rtlt)
end

function Star:kill()
	-- self.alive = false
	self.exists = false
end