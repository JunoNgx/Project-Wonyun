Wonyun = Class {}

function Wonyun:init(extraAmmo, armoured, shielded, barriered, weaponLevel, bulletCaptureEquipped)
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

	self.r 				= -math.pi/2
	self.oldx 			= self.x
	self.oldy 			= self.y
	self.velo = {
		x = 0,
		y = 0,
	}

	self.tweenDue = 0

	self.lifetime 	= 0
	self.alive 		= true
	self.exists 	= true

	-- Spawning parameters
	self.isArmoured 	= armoured or false
	self.isShielded 	= shielded or false
	self.isBarriered	= barriered or false
	self.ammo 			= 10 + 10 * extraAmmo
	self.weaponLevel = weaponLevel
	self.bulletCaptureEquipped = bulletCaptureEquipped or false

	self.currentWeapon = 1

	self.captureProcess = V.w_captureReloadTime
	self.reloadProcess 	= V.w_ReloadTime1

	self.gfx = gfx_wonyun
	self.gfx_armor = gfx_wonyun_armor
	self.gfx_barrier = gfx_wonyun_barrier

	self.throttle_gfx = gfx_throttle1
	self.throttle_dist = 32
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

		self.flux.update(dt)
		if Input.T.isDown then

			local Tspd_x = Input.T.getX() - Input.T.rx
			local Tspd_y = Input.T.getY() - Input.T.ry

				self.flux.to(self.velo, V.inputTweenTime, {
					x = Tspd_x * G.sensitivity,
					y = Tspd_y * G.sensitivity
					})

		else
			self.flux.to(self.velo, V.inputTweenTime, {x = 0, y = 0}):ease('linear')
		end

		-- Turns when moved horizontally
		local turningSpeed = 4

		local maxVelo = 600
		local rate = self.velo.x / maxVelo
		local des_r = -math.pi/2 + math.pi/4 * rate

		if des_r < -math.pi * 3/4 then des_r = -math.pi * 3/4 end
		if des_r > -math.pi * 1/4 then des_r = -math.pi * 1/4 end

		if self.r < des_r then self.r = self.r + dt * turningSpeed end
		if self.r > des_r then self.r = self.r - dt * turningSpeed end

		-- Keep in gameplay ground
		if self.x > gRes.w then self.x = gRes.w end
		if self.x < 0 then self.x = 0 end
		if self.y > gRes.h then self.y = gRes.h end
		if self.y < 0 then self.y = 0 end
	end
end

function Wonyun:draw()
	love.graphics.setColor(c.white)
	Jutils.draw(self.gfx, self.x, self.y, self.r)

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
	if self.isBarriered then
		love.graphics.setColor(150, 220, 200, 255)
		-- love.graphics.circle('line', self.x, self.y, 40)
		Jutils.draw(self.gfx_barrier, self.x, self.y, self.r)
	end
	-- Barrier ends

	-- Armor
	if self.isArmoured then
		love.graphics.setColor(255, 255, 255, 255)
		Jutils.draw(self.gfx_armor, self.x, self.y, self.r)
		Jutils.draw(self.gfx_armor, self.x, self.y, self.r)
	end
	-- Armor ends


	if G.debugMode then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.point(self.x, self.y)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

		love.graphics.setColor(0, 0, 255, 255)
		love.graphics.rectangle('line', self.x - self.w2/2, self.y - self.h2/2, self.w2, self.h2)
	end
end

----------------------------

function Wonyun:hit()
	if self.isBarriered and self.isShielded and self.isArmoured then
		self.isBarriered = false
	elseif not self.isBarriered and self.isShielded and self.isArmoured then
		self.isShielded = false
	elseif not self.isBarriered and not self.isShielded and self.isArmoured then
		self.isArmoured = false
	elseif not self.isBarriered and not self.isShielded and not self.isArmoured then
		self:kill()
	end
end

function Wonyun:kill()
	self.alive = false
	self:finishKill()

	spawnExplosion(self.x, self.y)
end

function Wonyun:finishKill()
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
	spawnBullet(1, p.x, p.y - 16, 0, -900)
end

function Wonyun:fireLateral()
	spawnBullet(1, p.x + 16, p.y, 900, 0)
	spawnBullet(1, p.x - 16, p.y, -900, 0)
end

function Wonyun:fireDiagonal()
	spawnBullet(1, p.x + 12, p.y - 12, 450, -450)
	spawnBullet(1, p.x + 12, p.y + 12, 450, 450)
	spawnBullet(1, p.x - 12, p.y + 12, -450, 450)
	spawnBullet(1, p.x - 12, p.y - 12, -450, -450)
end

function Wonyun:switchWeapon()
	if self.currentWeapon + 1 > self.weaponLevel then
		self.currentWeapon = 1
	else
		self.currentWeapon = self.currentWeapon + 1
	end

	Director.buttons.switchWeapon.switch()
end


function Wonyun:checkAmmo()
	return self.ammo > 0
end

function Wonyun:readyToFire()
	return self.reloadProcess <= 0
end

function Wonyun:checkVitals()
	return self.alive
end

----------------------------
-- Bullet Capture
----------------------------

function Wonyun:captureBullet()
	if self:readyToCapture() then

		self.captureProcess = V.w_captureReloadTime
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

function Wonyun:brake()
	self.flux.to(self.velo, V.inputTweenTime, {x = 0, y = 0}):ease('linear')
end