Drone = Class {}

function spawnDrone(x, y, r, supplyType)
	local drone = Pool.drone[1]

	drone:spawn(x, y, r, supplyType)

	table.insert(Director.alive, drone)
	table.remove(Pool.drone, 1)
end

function Drone:init()
	-- self.flux = require 'libs/flux'

	self.baseid = 'drone'
	self.objType = 'pickup'

	self.typeid = 'drone'
	self.alliance = 'neutral'

	self.x = 0
	self.y = 0
	self.w = 64
	self.h = 64

	self.r = 0
	self.lifetime = 0

	self.velo = {x = 0, y = 0}

	self.type = 0 --1, offense; 2, defense; 3, ammo
	self.col = 0
	self.pickedUp = false
	self.leaving = false

	self.exists = false
	self.alive = false

	self.gfx = 0
	self.gfx_fuselage = gfx_drone_fuselage
	self.throttle_gfx = gfx_throttle1
	self.throttle_dist = 48
end

function Drone:update(dt)
	if self.exists then 
		-- self.flux.update(dt)
		self.lifetime = self.lifetime + dt

		updateVelocity(self, dt)

		if not self.pickedUp then
			self.r = self.r + dt * self.turnSpeed
			-- self.r = lume.lerp(self.r, 100, 0.7)
		else
			
			-- if self.r ~= math.pi/2 then
			if self.r > 1.572 then
				-- if already picked up then repositioning radian
				self.r = lume.lerp(self.r, math.pi/2, 0.1)
			else
				-- radian already repositioned
				self:leave()
			end
		end

		if outOfBounds(self) then self:finishKill() end
	end
end

function Drone:draw()

	if self.leaving then
		-- Throttle
		local scale_x
		local scale_y

		scale_x = love.math.random(30,50)/100
		scale_y = love.math.random(30,40)/100

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
	end


	love.graphics.setColor(self.col)
	Jutils.draw(self.gfx_fuselage, self.x, self.y, self.r)
	love.graphics.setColor(255, 255, 255)
	Jutils.draw(self.gfx, self.x, self.y, self.r)
	

	if G.debugMode then
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

		love.graphics.setColor(255,255,255)
		love.graphics.print('r '..tostring(self.r), self.x + 32, self.y - 10)
		love.graphics.print('pickedUp '..tostring(self.pickedUp), self.x + 32, self.y)
		love.graphics.print('repositioned '..tostring(self.r == math.pi/2), self.x + 32, self.y + 10)
		love.graphics.print('leaving '..tostring(self.leaving), self.x + 32, self.y + 20)
		love.graphics.print('velo y '..tostring(self.velo.y), self.x + 32, self.y + 30)
	end
end

function Drone:kill()
	self.alive = false
end

function Drone:finishKill()
	self.alive = false
	self.exists = false
end

function Drone:acquired()
	self.pickedUp = true
	self.alive = false

	self.velo.x = 0
	self.velo.y = 0

	-- local leave = function() self:leave() end

	-- self.flux.to(self, 2, { r_display = math.pi/2}):oncomplete(leave)
end

function Drone:leave()
	self.velo.y = lume.lerp(self.velo.y, 500, 0.1)
	self.leaving = true
end

function Drone:spawn(x, y, r, supplyType)
	self.x = x
	self.y = y
	self.r = r
	self.velo.x = V.drone_velo * math.cos(r)
	self.velo.y = V.drone_velo * math.sin(r)

	self.type = supplyType

	if self.type == 1 then
		self.gfx = gfx_drone_symbol[1]
		self.col = {255,0,0}
	elseif self.type == 2 then
		self.gfx = gfx_drone_symbol[2]
		self.col = {0,0,255}
	elseif self.type == 3 then
		self.gfx = gfx_drone_symbol[3]
		self.col = {0,255,0}
	end

	self.pickedUp = false
	self.leaving = false
	self.turnSpeed = love.math.random(10,50)/10

	self.lifetime = 0
	self.exists = true
	self.alive = true
end