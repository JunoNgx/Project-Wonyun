Wonyun = Class {}

function Wonyun:init(extraAmmo, hp, weaponLevel, bulletCaptureEquipped)
	self.flux = require 'libs/flux'

	self.typeid = 'wonyun'
	self.objType = 'vessel'
	self.alliance = 'friendly'

	-- Basic object properties
	self.x 				= gRes.w * 0.5
	self.y 				= gRes.h * 0.75
	self.w 				= 16
	self.h 				= 16
	self.w2 			= 32
	self.h2 			= 32

	self.r 				= math.pi * 3/2
	self.oldx 			= self.x
	self.oldy 			= self.y
	self.velo = {
		x = 0,
		y = 0,
	}

	self.rotateDir 				= 0 -- When moving horizontally -1, left, 0, not rotating, 1 right

	self.lifetime 				= 0
	self.alive 					= true
	self.exists 				= true

	self.hp 					= hp
	self.ammo 					= 10 + 10 * extraAmmo
	self.weaponLevel 			= weaponLevel
	self.bulletCaptureEquipped 	= bulletCaptureEquipped or false

	self.currentWeapon 			= 1

	self.captureProcess 		= V.w_captureReloadTime
	self.reloadProcess 			= V.w_ReloadTime1

	self.parts = {
		rhombus_r = 64,
		rhombus_a = 255,
		rhombus_mode = 'ready',
		bulletDir_a = 1,
		bulletDir_gfx = gfx_parts_arrow,
	}

	self.gfx 			= gfx_wonyun
	self.gfx_armor 		= gfx_wonyun_armor
	self.gfx_barrier 	= gfx_wonyun_barrier

	self.throttle_gfx 	= gfx_throttle1
	self.throttle_dist	= 32
end

function Wonyun:update(dt)
	if self:checkVitals() then
		self.lifetime = self.lifetime + dt

		-- Ready to fire when reaches zero
		if self.reloadProcess > 0 then 
			self.reloadProcess  = self.reloadProcess - dt
		end

		-- Ready to capture bullet when reaches zero
		if self.captureProcess > 0 then
			self.captureProcess = self.captureProcess - dt
		end

		updateVelocity(self, dt)


		if Input.mode == 'touch' then

			self.flux.update(dt)
			if Input.T.isDown then

				local Tspd_x = Input.T.x - Input.T.rx
				local Tspd_y = Input.T.y - Input.T.ry

					self.flux.to(self.velo, V.inputTweenTime, {
						x = Tspd_x * G.sensitivity,
						y = Tspd_y * G.sensitivity
						})

			else
				self.flux.to(self.velo, V.inputTweenTime, {x = 0, y = 0}):ease('linear')

				if -2 < self.velo.x or self.velo.x < 2 then self.velo.x = 0 end
				if -2 < self.velo.y or self.velo.y < 2 then self.velo.y = 0 end
			end

		elseif Input.mode == 'keyboard' then
			if Input.K.Up then
				self.velo.y = -V.w_dpadVelo
			elseif Input.K.Dn then
				self.velo.y = V.w_dpadVelo
			else
				self.velo.y = 0
			end

			if Input.K.Lt then
				self.velo.x = -V.w_dpadVelo
			elseif Input.K.Rt then
				self.velo.x = V.w_dpadVelo
			else
				self.velo.x = 0
			end

		elseif Input.mode == 'gamepad' then
			self.velo.x = Input.P.dx * V.w_dpadVelo
			self.velo.y = Input.P.dy * V.w_dpadVelo
		end

		-- Rotation when move horizontally
		local rotateThreshold = 100

		if Input.mode == 'touch' then
			if self.velo.x < -rotateThreshold then
				self.rotateDir = -1
			elseif -rotateThreshold < self.velo.x and self.velo.x < rotateThreshold then
				self.rotateDir = 0
			elseif self.velo.x > rotateThreshold then
				self.rotateDir = 1
			end
		else
			if self.velo.x < 0 then
				self.rotateDir = -1
			elseif self.velo.x == 0 then
				self.rotateDir = 0
			elseif self.velo.x > 0 then
				self.rotateDir = 1
			end
		end

		if self.rotateDir == -1 then
			if self.r > math.pi * 5/4 then self.r = self.r - dt * V.w_rotateSpd end
		elseif self.rotateDir == 0 then
			-- math.pi * 3/2 == 4.71238898038
			if self.r < 4.65 then
				self.r = self.r + dt * V.w_rotateSpd
			elseif self.r > 4.75 then
				self.r = self.r - dt * V.w_rotateSpd
			end
		elseif self.rotateDir == 1 then
			if self.r < math.pi * 7/4 then self.r = self.r + dt * V.w_rotateSpd end
		end

		-- Keep in gameplay ground
		if self.x > gRes.w then self.x = gRes.w end
		if self.x < 0 then self.x = 0 end
		if self.y > gRes.h then self.y = gRes.h end
		if self.y < 0 then self.y = 0 end

		-- Die when hp depletes
		if self.hp <= 0 then self:kill() end

		-- Parts thingies
		if self.parts.bulletDir_a > 7 then
			self.parts.bulletDir_a = self.parts.bulletDir_a - V.w_parts_bullet_fadeSpd * dt
		else
			self.parts.bulletDir_a = 0
		end

		if self.parts.rhombus_mode == 'ready' then
			if self.parts.rhombus_a > 7 then
				self.parts.rhombus_a = self.parts.rhombus_a - V.w_parts_rSpd_ready * dt
				self.parts.rhombus_r = self.parts.rhombus_r + V.w_parts_rSpd_ready * dt
			else
				self.parts.rhombus_a = 0
			end
		elseif self.parts.rhombus_mode == 'fire' then
			if self.parts.rhombus_a > 7 then
				self.parts.rhombus_a = self.parts.rhombus_a - V.w_parts_rSpd_fire * dt
				self.parts.rhombus_r = self.parts.rhombus_r - V.w_parts_rSpd_fire * dt
			else
				self.parts.rhombus_a = 0
			end
		end

		-- Flash the rhombus when ready to fire
		if self.parts.rhombus_mode == 'fire' and self:readyToCapture() then
			self.parts.rhombus_r = 16
			self.parts.rhombus_a = 255
			self.parts.rhombus_mode = 'ready'
		end

	end
end

function Wonyun:draw()
	love.graphics.setColor(c.white)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

	-- Arrows indicating firing direction upon switching weapon
	local arrowDist = 128
	love.graphics.setColor(255, 255, 255, self.parts.bulletDir_a)
	if self.currentWeapon == 1 then
		Jutils.draw(self.parts.bulletDir_gfx, self.x, self.y - arrowDist, -math.pi/2)
	elseif self.currentWeapon == 2 then
		Jutils.draw(self.parts.bulletDir_gfx, self.x + arrowDist, self.y, 0)
		Jutils.draw(self.parts.bulletDir_gfx, self.x - arrowDist, self.y, math.pi)
	elseif self.currentWeapon == 3 then
		local arrowDistMod = arrowDist * math.cos(math.pi/4)
		Jutils.draw(self.parts.bulletDir_gfx, self.x + arrowDistMod, self.y - arrowDistMod, -math.pi/4)
		Jutils.draw(self.parts.bulletDir_gfx, self.x + arrowDistMod, self.y + arrowDistMod, math.pi/4)
		Jutils.draw(self.parts.bulletDir_gfx, self.x - arrowDistMod, self.y + arrowDistMod, math.pi * 0.75)
		Jutils.draw(self.parts.bulletDir_gfx, self.x - arrowDistMod, self.y - arrowDistMod, -math.pi * 0.75)
	end

	-- Quadrilateral indicating bullet capture
	love.graphics.setColor(0, 255, 255, self.parts.rhombus_a)
	love.graphics.setLineWidth(5)
	love.graphics.polygon('line',
		self.x + self.parts.rhombus_r, self.y,
		self.x, self.y + self.parts.rhombus_r,
		self.x - self.parts.rhombus_r, self.y,
		self.x, self.y - self.parts.rhombus_r
		)
		
	-- Throttle
	local scale_x
	local scale_y

	if self.velo.y < -100 then -- moving up, big throttle
		scale_x = love.math.random(25,40)/100
		scale_y = love.math.random(20,30)/100
	elseif self.velo.y > 50 then -- moving down, no/small throttle
		scale_x = love.math.random(5,10)/100
		scale_y = love.math.random(7,8)/100
	else -- normal throttle
		scale_x = love.math.random(12,24)/100
		scale_y = love.math.random(8,16)/100
	end

	-- local radian = self.r + love.math.random(-math.pi, math.pi)
	local randomizer = love.math.random(-4,4)/100
	local radian = self.r + randomizer

	love.graphics.setColor(150, 220, 200, 255)
	Jutils.draw(self.throttle_gfx,
		self.x - self.throttle_dist * math.cos(radian),
		self.y - (self.throttle_dist + love.math.random(-5,5))* math.sin(radian),
		radian + love.math.random(-20,20)/100,
		scale_x, scale_y)
	-- Throttle ends

	-- Barrier
	if self.hp > 2 then 
		love.graphics.setColor(255, 255, 255, 255)
		Jutils.draw(self.gfx_barrier, self.x, self.y, self.r)
	end

	-- Armor
	if self.hp > 1 then
		love.graphics.setColor(255, 255, 255, 255)
		Jutils.draw(self.gfx_armor, self.x, self.y, self.r)
	end


	if G.debugMode then
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.point(self.x, self.y)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

		love.graphics.setColor(0, 0, 255, 255)
		love.graphics.rectangle('line', self.x - self.w2/2, self.y - self.h2/2, self.w2, self.h2)

		love.graphics.setColor(250, 240, 90,255)
		love.graphics.circle('line', self.x, self.y, gRes.w * 0.075)
	end
end

----------------------------

function Wonyun:hit(damage)
	self.hp = self.hp - damage
end

function Wonyun:kill()
	self.alive = false
	self:finishKill()

	spawnExplosion(self.x, self.y, 1, 3)
end

function Wonyun:finishKill()
	self.alive = false
	self.exists = false
end

----------------------------
-- Offensive functions
----------------------------

function Wonyun:fire()
	if self:readyToFire() then
		if self:checkAmmo() then
			-- spawnBullet(alliance, x, y, velo_x, velo_y)
			if self.currentWeapon == 1 then
				self:fireFront()
				self.reloadProcess = V.w_ReloadTime1
			elseif self.currentWeapon == 2 then
				self:fireLateral()
				self.reloadProcess = V.w_ReloadTime2
			elseif self.currentWeapon == 3 then
				self:fireDiagonal()
				self.reloadProcess = V.w_ReloadTime3
			end
			
			self.ammo = self.ammo - 1
		else
			-- love.audio.play(sfx_pNoAmmo)
		end
	end
end

function Wonyun:fireFront()
	spawnBullet(1, p.x, p.y - 16, 0, -V.w_bulletVelo)
end

function Wonyun:fireLateral()
	spawnBullet(1, p.x + 16, p.y, V.w_bulletVelo, 0)
	spawnBullet(1, p.x - 16, p.y, -V.w_bulletVelo, 0)
end

function Wonyun:fireDiagonal()
	spawnBullet(1, p.x + 12, p.y - 12, V.w_bulletVelo/2, -V.w_bulletVelo/2)
	spawnBullet(1, p.x + 12, p.y + 12, V.w_bulletVelo/2, V.w_bulletVelo/2)
	spawnBullet(1, p.x - 12, p.y + 12, -V.w_bulletVelo/2, V.w_bulletVelo/2)
	spawnBullet(1, p.x - 12, p.y - 12, -V.w_bulletVelo/2, -V.w_bulletVelo/2)
end

function Wonyun:switchWeapon()
	if self.currentWeapon + 1 > self.weaponLevel then
		self.currentWeapon = 1
	else
		self.currentWeapon = self.currentWeapon + 1
	end

	self.parts.bulletDir_a = 255
	Director.buttons.switchWeapon.switch()
end

function Wonyun:readyToFire()
	return self.reloadProcess <= 0
end

----------------------------
-- Bullet Capture
----------------------------

function Wonyun:captureBullet()
	if self:readyToCapture() then
		wonyunBulletCapture(self)
		self.captureProcess = V.w_captureReloadTime

		-- Visual thingies
		self.parts.rhombus_r = 256
		self.parts.rhombus_a = 255
		self.parts.rhombus_mode = 'fire'
	end
end

function Wonyun:readyToCapture()
	return self.captureProcess <= 0
end

-----------------------------

function Wonyun:AmendOldPos()
	self.oldx = self.x
	self.oldy = self.y
end

function Wonyun:checkAmmo()
	return self.ammo > 0
end

function Wonyun:checkVitals()
	return self.alive
end

function Wonyun:gainAmmo(amount)
	self.ammo = self.ammo + amount
end

-- function Wonyun:brake()
-- 	self.flux.to(self.velo, V.inputTweenTime, {x = 0, y = 0}):ease('linear')
-- end