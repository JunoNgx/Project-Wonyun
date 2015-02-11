Keadani = Class {}

function spawnKeadani(unitType, x, y, velo_x, velo_y)
	-- local r = r or math.pi/2
	local keadani = Pool.keadani[1]
	local unitType = unitType

	keadani:spawn(unitType, x, y, velo_x, velo_y)

	table.insert(Director.alive, keadani)
	table.remove(Pool.keadani, 1)
end

function Keadani:init()

	self.baseid = 'keadani'
	self.objType = 'vessel'

	self.typeid = 'undefinedEnemy'
	self.alliance = 'hostile'
	self.fireRate = V.k_defaultFireRate
	
	self.x = 0
	self.y = 0
	-- self.w = 1
	-- self.h = 1
	self.r = math.pi/2
	self.lifetime = 0
	self.velo = {x = 0, y = 0}
	self.alive 	= false
	self.exists = false

	self.throttle_gfx = nil
	self.throttle_dist = nil
end

function Keadani:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		-- Ready to fire when reaches zero
		if self.reloadProcess > 0 then 
			self.reloadProcess  = self.reloadProcess - dt
		end

		if self.alive then
			-- Fire when ready
			-- if self:readyToFire() then 
			-- 	self:fire()
			-- end
		
			updateVelocity(self, dt)

			if outOfBounds(self) then self:finishKill() end
		end
	end
end

function Keadani:draw()
	if self.exists then
		love.graphics.setColor(255,255,255,255)
		Jutils.draw(self.gfx, self.x, self.y, self.r)

		-- Throttle
		local scale_x = love.math.random(15,30)/100
		local scale_y = love.math.random(10,20)/100

		local randomizer = love.math.random(-7,7)/100
		local radian = self.r + randomizer

		love.graphics.setColor(150, 220, 200, 255)
		if self.typeid == 'riley' then
			for i = 1, 3 do
			Jutils.draw(self.throttle_gfx,
				self.x - self.throttle_dist * math.cos(radian),
				self.y - (self.throttle_dist + love.math.random(-5,5))* math.sin(radian),
				radian + love.math.random(-100,100)/100,
				scale_x, scale_y)
			end
		end

		if G.debugMode then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

			love.graphics.setColor(255,255,255)
			love.graphics.print(self.velo.y, self.x + 32, self.y)
			love.graphics.print(self.typeid, self.x + 48, self.y)
		end
	end
end

--------------------------------

function Keadani:hit()
	self:kill()
end

function Keadani:kill()
	self.alive = false
	
	if self.typeid == 'riley' then
		spawnExplosion(self.x, self.y, 24, love.math.random(2,3))
	elseif self.typeid == 'augustus' then
		spawnExplosion(self.x, self.y, 24, love.math.random(2,3))
	elseif self.typeid == 'dulce' then
		spawnExplosion(self.x, self.y)
	elseif self.typeid == 'hammerhead' then
		spawnExplosion(self.x, self.y, 60, love.math.random(3,6))
	elseif self.typeid == 'koltar' then
		spawnExplosion(self.x, self.y, 48, love.math.random(4,7))
	end

	self:finishKill()
end

function Keadani:finishKill()
	self.typeid = 'undefinedEnemy'
	self.velo 	= {x = 0, y = 0}
	self.alive 	= false
	self.exists = false
end

function Keadani:readyToFire()
	return self.reloadProcess <= 0
end

function Keadani:fire()
	self.reloadProcess = self.fireRate
	-- spawnBullet(alliance, x, y, velo_x, velo_y)
	spawnBullet(2, self.x, self.y + 16)
end

function Keadani:spawn(unitType, x, y, velo_x, velo_y)

	if unitType == 1 then -- riley
		self.typeid				= 'riley'
		self.w 					= 140
		self.h 					= 64
		self.fireRate 			= V.k_rileyFireRate

		self.gfx 				= gfx_riley
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 24
	elseif unitType == 2 then -- augustus/frigate
		self.typeid				= 'augustus'
		self.w 					= 72
		self.h 					= 72
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_augustus
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 3 then -- dulce/drone, homing fire
		self.typeid				= 'dulce'
		self.w 					= 100
		self.h 					= 48
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_dulce
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 4 then -- hammerhead/sidefire
		self.typeid				= 'hammerhead'
		self.w 					= 96
		self.h 					= 144
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_hammerhead
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 5 then -- koltar/boss, 8-direction shot
		self.typeid				= 'koltar'
		self.w 					= 160
		self.h 					= 48
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_koltar
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	end

	self.reloadProcess 		= self.fireRate
	self.x 					= x
	self.y 					= y
	self.lifetime 			= 0

	local velo_x = velo_x or 0
	self.velo.x = velo_x
	local velo_y = velo_y or V.k_defaultVeloY
	self.velo.y = velo_y

	self.alive 	= true
	self.exists = true
end