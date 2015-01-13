Player = Class {}

function Player:init()

	self.x 			= gRes.w * 0.5
	self.y 			= gRes.h * 0.75
	self.w 			= 36
	self.h 			= 36
	self.w2 		= 64
	self.h2 		= 64

	self.r 			= -math.pi/2
	self.ox 		= nil
	self.oy 		= nil

	self.lifetime 	= 0
	self.reloaded 	= false

	self.gfx = loader.Image.player
end

-- function Player:endstats(self)
-- 	return string.format("x: %.02f, y: %.02f",
-- 		self.x, self.y)
-- end

function Player:update(dt)

	self.lifetime = self.lifetime + dt

	if Input.T.isDown then
		self.x = self.ox + (Input.T.getX() - Input.T.ox) * G.sensitivity
		self.y = self.oy + (Input.T.getY() - Input.T.oy) * G.sensitivity
	end

	if self.x > gRes.w then self.x = gRes.w end
	if self.x < 0 then self.x = 0 end
	if self.y > gRes.h then self.y = gRes.h end
	if self.y < 0 then self.y = 0 end
end

function Player:draw()
	love.graphics.setColor(c.white)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

	if G.debugMode then
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

		love.graphics.setColor(0,0,255,255)
		love.graphics.rectangle('line', self.x - self.w2/2, self.y - self.h2/2, self.w2, self.h2)
	end
end

function Player:AmendOldPos()
	self.ox = self.x
	self.oy = self.y
end