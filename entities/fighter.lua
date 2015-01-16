Fighter = Class {}

function Fighter:init()

	self.typeid = 'fighter'
	self.objType = 'vessel'
	self.alliance = 'hostile'

	self.x = 0
	self.y = 0
	self.w = 48
	self.h = 48
	self.r = math.pi/2

	self.lifetime 	= 0
	self.reloadProcess = V.e_fighterFireRate
	self.velo = 0

	self.alive = false
	self.exists = false

	self.gfx = loader.Image.fighter
end

function Fighter:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		-- Ready to fire when reaches zero
		if self.reloadProcess > 0 then 
			self.reloadProcess  = self.reloadProcess - dt
		end

		-- Fire when ready
		if self:readyToFire() then 
			self:fire()
		end

		if self.alive then
			self.x = self.x + self.velo*math.cos(self.r)*dt
			self.y = self.y + self.velo*math.sin(self.r)*dt
			if self.x < 0 - V.gameplayMargin or self.x > gRes.w + V.gameplayMargin then self:finishKill() end
			if self.y < 0 - V.gameplayMargin or self.y > gRes.h + V.gameplayMargin then self:finishKill() end
		end
	end
end

function Fighter:draw()
	love.graphics.setColor(255,0,0,255)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

	if G.debugMode then
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	end
end

--------------------------------

function Fighter:hit()
	self:kill()
end

function Fighter:kill()
	self.alive = false
	self:finishKill()
end

function Fighter:finishKill()
	self.velo = 0

	self.alive = false
	self.exists = false
end

function Fighter:readyToFire()
	return self.reloadProcess <= 0
end

function Fighter:fire()
	self.reloadProcess = V.e_fighterFireRate
	spawnBullet_e(self.x, self.y)
end

function Fighter:spawn(x, y, r)
	self.x 					= x
	self.y 					= y
	self.velo 				= V.e_fighterVelo
	self.r 					= r or math.pi/2

	self.reloadedProcess 	= V.e_fighterFireRate
	self.lifetime 			= 0

	self.alive 				= true
	self.exists 			= true
end