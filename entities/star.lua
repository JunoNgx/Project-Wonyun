Star = Class {}

function Star:init()

	self.baseid = 'star'
	self.typeid = 'star'
	self.objType = 'decorBack'

	self.x = 0
	self.y = 0

	self.scale = 1
	self.velo = {x = 0, y = 0}
	self.alive = false

	self.gfx = gfx_star
end

function Star:update(dt)
	updateVelocity(self, dt)

	if outOfBounds(self) then self:reset() end
end

function Star:draw()
	love.graphics.setColor(255,255,255,255)
	Jutils.draw(self.gfx, self.x, self.y, 0, self.scale, self.scale)
end

function Star:reset()
	local randomizer = love.math.random(1,7)/10

	self.x = love.math.random(V.margin_rtlt, gRes.w + V.margin_rtlt)
	self.y = -100

	self.scale = randomizer
	self.velo.y = randomizer * V.s_veloY

	self.alive = true
end

function Star:spread()
	self.x = love.math.random(-V.margin_rtlt, gRes.w + V.margin_rtlt)
	self.y = love.math.random(-V.margin_rtlt, gRes.h + V.margin_rtlt)
end

function Star:kill()
	self.alive = false
end