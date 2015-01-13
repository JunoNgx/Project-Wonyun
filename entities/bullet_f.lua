Bullet_f = Class {}

function Bullet_f:init()

	self.typeid = 'bullet_f'

	self.x = 0
	self.y = 0
	self.w = 16
	self.h = 16
	self.alive = false
	self.exists = false

	self.lifetime = 0

	self.r = r or -math.pi/2
	self.gfx = loader.Image.bullet_f
end

-- function Bullet_f:endstats(self)
-- 	return string.format("x: %.02f, y: %.02f",
-- 		self.x, self.y)
-- end

function Bullet_f:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		if self.alive then
			self.x = self.x + V.bullet_fVelo*math.cos(self.r)*dt
			self.y = self.y + V.bullet_fVelo*math.sin(self.r)*dt
			if self.x < 0 or self.x > gRes.w then self:finishKill() end
			if self.y < 0 or self.y > gRes.h then self:finishKill() end
		end
	end
end

function Bullet_f:draw()
	love.graphics.setColor(255,0,0,255)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

	if G.debugMode then
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	end
end

------------------------------------

function Bullet_f:kill()
	self.alive = false
end

function Bullet_f:finishKill()
	self.alive 	= false
	self.exists = false
end

function Bullet_f:spawn(x, y, r)
	self.x = x
	self.y = y
	self.r = r or -math.pi/2

	self.alive = true
	self.exists = true
end