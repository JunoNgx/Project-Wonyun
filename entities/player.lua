Player = Class {}

function Player:init(extraAmmo, armoured, shielded)

	self.typeid = 'player'
	self.objType = 'vessel'
	self.alliance = 'friendly'

	self.x 			= gRes.w * 0.5
	self.y 			= gRes.h * 0.75
	self.w 			= 36
	self.h 			= 36
	self.w2 		= 64
	self.h2 		= 64

	self.r 			= -math.pi/2
	self.oldx 		= self.x
	self.oldy 		= self.y
	self.isArmoured = armoured or false
	self.isShielded = shielded or false
	self.ammo 		= 10 + 10 * extraAmmo

	self.lifetime 	= 0
	self.reloadProcess 	= V.playerReloadTime

	self.alive = true
	self.exists = true

	self.gfx = loader.Image.player
end

-- function Player:endstats(self)
-- 	return string.format("x: %.02f, y: %.02f",
-- 		self.x, self.y)
-- end

function Player:update(dt)

	self.lifetime = self.lifetime + dt

	-- Ready to fire when reaches zero
	if self.reloadProcess > 0 then 
		self.reloadProcess  = self.reloadProcess - dt
	end

	if Input.T.isDown then
		self.x = self.oldx + (Input.T.getX() - Input.T.ox) * G.sensitivity
		self.y = self.oldy + (Input.T.getY() - Input.T.oy) * G.sensitivity
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

----------------------------

function Player:hit()
	if self.isShielded and self.isArmoured then
		self.isShielded = false
	elseif not self.isShielded and self.isArmoured then
		self.isArmoured = false
	elseif not self.isShielded and not self.isArmoured then
		self:kill()
	end
end

function Player:kill()
	self.alive = false
	self:finishKill()
end

function Player:finishKill()
	self.alive = false
	self.exists = false

	-- Debug code
	-- Alarm:after(2, function()
	-- 	Gamestate.switch(result)
	-- end)
end

----------------------------
-- Offensive functions
----------------------------

function Player:fire()
	if self:readyToFire() then
		if self:checkAmmo() then
			spawnBullet_f()
			
			self.reloadProcess = V.playerReloadTime
			self.ammo = self.ammo - 1
		else
			-- love.audio.play(sfx_pNoAmmo)
		end
	end
end

function Player:checkAmmo()
	return self.ammo > 0
end

function Player:readyToFire()
	return self.reloadProcess <= 0
end

function Player:checkVitals()
	return self.alive
end

-----------------------------

function Player:AmendOldPos()
	self.oldx = self.x
	self.oldy = self.y
end