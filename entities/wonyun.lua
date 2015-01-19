Wonyun = Class {}

function Wonyun:init(extraAmmo, armoured, shielded)
	self.flux = require 'libs/flux'

	self.typeid = 'wonyun'
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

	self.velo = {
		x = 0,
		y = 0,
	}
	self.tweenDue = 0

	self.lifetime 	= 0
	self.reloadProcess 	= V.w_ReloadTime

	self.alive = true
	self.exists = true

	self.gfx = gfx_wonyun

	self.throttle_gfx = gfx_throttle1
	self.throttle_dist = 42
end

function Wonyun:update(dt)
	if self:checkVitals() then
		self.lifetime = self.lifetime + dt

		-- Ready to fire when reaches zero
		if self.reloadProcess > 0 then 
			self.reloadProcess  = self.reloadProcess - dt
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

	local scale_x
	local scale_y

	if self.velo.y < -100 then -- moving up, big throttle
		scale_x = love.math.random(25,40)/100
		scale_y = love.math.random(15,25)/100
	elseif self.velo.y > 50 then -- moving down, no/small throttle
		scale_x = love.math.random(5,10)/100
		scale_y = love.math.random(7,8)/100
	else -- normal throttle
		scale_x = love.math.random(15,30)/100
		scale_y = love.math.random(10,20)/100
	end

	-- local radian = self.r + love.math.random(-math.pi, math.pi)
	local randomizer = love.math.random(-4,4)/100
	local radian = self.r + randomizer

	love.graphics.setColor(150, 220, 200, 255)
	Jutils.draw(self.throttle_gfx,
		self.x - self.throttle_dist * math.cos(radian),
		self.y - (self.throttle_dist + love.math.random(-5,5))* math.sin(radian),
		radian,
		scale_x, scale_y)


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
	if self.isShielded and self.isArmoured then
		self.isShielded = false
	elseif not self.isShielded and self.isArmoured then
		self.isArmoured = false
	elseif not self.isShielded and not self.isArmoured then
		self:kill()
	end
end

function Wonyun:kill()
	self.alive = false
	self:finishKill()
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
			spawnBullet(1, p.x, p.y - 16)
			
			self.reloadProcess = V.w_ReloadTime
			self.ammo = self.ammo - 1
		else
			-- love.audio.play(sfx_pNoAmmo)
		end
	end
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

-----------------------------

function Wonyun:AmendOldPos()
	self.oldx = self.x
	self.oldy = self.y
end

function Wonyun:brake()
	self.flux.to(self.velo, V.inputTweenTime, {x = 0, y = 0}):ease('linear')
end