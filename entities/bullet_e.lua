Bullet_e = Class {}

function Bullet_e:init()

	self.typeid = 'bullet_e'
	self.objType = 'bullet'
	self.alliance = 'hostile'
	self.damage = V.bullet_eDamage

	self.x = 0
	self.y = 0
	self.w = 16
	self.h = 16
	self.r = -math.pi/2

	self.lifetime = 0
	self.velo = 0

	self.alive = false
	self.exists = false

	-- self.gfx_norm = loader.Image.bullet_e
	-- self.gfx_muzzle = loader.Image.bullet_f_muzzle

	self.gfx = loader.Image.bullet_e
end

-- function Bullet_f:endstats(self)
-- 	return string.format("x: %.02f, y: %.02f",
-- 		self.x, self.y)
-- end

function Bullet_e:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		-- if self.lifetime > V.bullet_fMuzzleTime and self.gfx == self.gfx_muzzle then
		-- 	self.gfx = self.gfx_norm
		-- end

		if self.alive then
			self.x = self.x + self.velo*math.cos(self.r)*dt
			self.y = self.y + self.velo*math.sin(self.r)*dt
			if self.x < 0 - V.gameplayMargin or self.x > gRes.w + V.gameplayMargin then self:finishKill() end
			if self.y < 0 - V.gameplayMargin or self.y > gRes.h + V.gameplayMargin then self:finishKill() end
		end
	end
end

function Bullet_e:draw()
	love.graphics.setColor(0,0,255,255)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

	if G.debugMode then
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	end
end

------------------------------------

function Bullet_e:kill()
	self.alive = false
end

function Bullet_e:finishKill()
	self.velo = 0

	self.alive 	= false
	self.exists = false
end

function Bullet_e:spawn(x, y, r)
	self.x 			= x
	self.y 			= y
	self.velo 		= V.bullet_eVelo
	self.r 			= r or -math.pi/2

	-- self.gfx 		= self.gfx_muzzle
	self.lifetime 	= 0

	self.alive 		= true
	self.exists 	= true
end