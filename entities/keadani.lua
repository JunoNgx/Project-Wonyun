Keadani = Class {}

function spawnKeadani(unitType, x, y, r, velo)
	local r = r or math.pi/2
	local keadani = Pool.keadani[1]
	local unitType = unitType

	keadani:spawn(unitType, x, y, r, velo)

	table.insert(Director.alive, keadani)
	table.remove(Pool.keadani, 1)
end

function Keadani:init()

	self.baseid = 'keadani'
	self.objType = 'vessel'

	self.typeid = 'keadani'
	self.unitType = 'undefinedEnemy'
	self.alliance = 'hostile'
	self.fireRate = V.k_defaultFireRate
	
	self.x = 0
	self.y = 0
	-- self.w = 1
	-- self.h = 1
	self.r = math.pi/2
	self.lifetime = 0
	self.velo = {x = 0, y = 0}

	self.hp = 0
	self.spec = nil -- specifications variables for each unit

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
			if self:readyToFire() then 
				self:fire()
			end
		
			updateVelocity(self, dt)

			if outOfBounds(self) then self:finishKill() end
		end

		if self.hp <= 0 then self:kill() end
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
		if self.unitType == 'riley' then
			for i = 1, 3 do
			Jutils.draw(self.throttle_gfx,
				self.x - self.throttle_dist * math.cos(radian),
				self.y - (self.throttle_dist + love.math.random(-5,5))* math.sin(radian),
				radian + love.math.random(-100,100)/100,
				scale_x, scale_y)
			end
		end

		if G.debugMode then
			love.graphics.setLineWidth(1)
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

			love.graphics.setColor(255,255,255)
			love.graphics.print(self.velo.y, self.x + 32, self.y)
			love.graphics.print(self.unitType, self.x + 48, self.y)
		end
	end
end

--------------------------------

function Keadani:hit(damage)
	self.hp = self.hp - damage
end

function Keadani:kill()
	self.alive = false
	
	if self.unitType == 'riley' then
		spawnExplosion(self.x, self.y, 2, 2)
	elseif self.unitType == 'augustus' then
		spawnExplosion(self.x, self.y, 2, 3)
	elseif self.unitType == 'dulce' then
		spawnExplosion(self.x, self.y, 2, 2)
	elseif self.unitType == 'hammerhead' then
		spawnExplosion(self.x, self.y, 2, 3)
	elseif self.unitType == 'koltar' then
		spawnExplosion(self.x, self.y, 2, 3)
	end

	self:finishKill()
end

function Keadani:finishKill()
	self.unitType = 'undefinedEnemy'
	self.velo 	= {x = 0, y = 0}
	self.alive 	= false
	self.exists = false
end

function Keadani:readyToFire()
	return self.reloadProcess <= 0
end

function Keadani:fire()
	self.reloadProcess = self.fireRate



	if self.unitType == 'riley' then

		local velo_x = V.be_defaultVelo * math.cos(self.r)
		local velo_y = V.be_defaultVelo * math.sin(self.r)
		local muzzleDist = 16
		spawnBullet(2, self.x + muzzleDist * math.cos(self.r), self.y + muzzleDist * math.sin(self.r),
			velo_x, velo_y)

	elseif self.unitType == 'dulce' then

		spawnBullet(2, self.x, self.y, 0, 100)

	elseif self.unitType == 'augustus' then

		local muzzleDist = 32
		for i = 0, 2 do

			local shotDir = (self.r - math.pi/4) + i * math.pi/4
			local velo_x = V.be_defaultVelo * math.cos(shotDir)
			local velo_y = V.be_defaultVelo * math.sin(shotDir)

			spawnBullet(2, self.x + muzzleDist * math.cos(self.r), self.y + muzzleDist * math.sin(self.r),
				velo_x, velo_y)
		end

	elseif self.unitType == 'hammerhead' then

		local hammerVelo = 200

		spawnBullet(2, self.x + 16, self.y + 16, hammerVelo, self.velo.y)
		spawnBullet(2, self.x - 16, self.y + 16, -hammerVelo, self.velo.y)
		spawnBullet(2, self.x - 16, self.y - 16, -hammerVelo, self.velo.y)
		spawnBullet(2, self.x + 16, self.y - 16, hammerVelo, self.velo.y)

	elseif self.unitType == 'koltar' then

		local koltarVelo = 300

		local muzzleDist = 24
		if not self.oddShot then

			spawnBullet(2, self.x + muzzleDist, self.y, koltarVelo, 0) -- right
			spawnBullet(2, self.x, self.y + muzzleDist, 0, koltarVelo) -- bottom
			spawnBullet(2, self.x - muzzleDist, self.y, -koltarVelo, 0) -- left
			spawnBullet(2, self.x, self.y - muzzleDist, 0, -koltarVelo) -- top

			self.oddShot = true
		else

			mod = math.cos(math.pi/4)

			spawnBullet(2, self.x + muzzleDist, self.y + muzzleDist, V.be_defaultVelo * mod, V.be_defaultVelo * mod)
			spawnBullet(2, self.x + muzzleDist, self.y - muzzleDist, V.be_defaultVelo * mod, -V.be_defaultVelo * mod)
			spawnBullet(2, self.x - muzzleDist, self.y - muzzleDist, -V.be_defaultVelo * mod, -V.be_defaultVelo * mod)
			spawnBullet(2, self.x - muzzleDist, self.y + muzzleDist, -V.be_defaultVelo * mod, V.be_defaultVelo * mod)

			self.oddShot = false
		end



		-- for i = 0, 3 do

		-- 	local shotDir

		-- 	if oddShot = false then
		-- 		shotDir = i * math.pi/4
		-- 	elseif 
		-- 		shotDir = math.pi/8 + i * math.pi/4
		-- 	end

		-- 	local velo_x = V.be_defaultVelo * math.cos(shotDir)
		-- 	local velo_y = V.be_defaultVelo * math.sin(shotDir)

		-- 	spawnBullet(2, self.x + muzzleDist * math.cos(self.r), self.y + muzzleDist * math.sin(self.r),
		-- 		velo_x, velo_y)

			
		-- end

		-- Switch firing direction cycle
		-- if self.oddShot then self.oddShot = false else self.oddShot = true end



	end
	
end

function Keadani:spawn(unitType, x, y, r, velo)

	local velocity = velo or V.k_defaultVelo

	if unitType == 1 then -- riley
		self.unitType			= 'riley'
		self.w 					= 140
		self.h 					= 64
		self.fireRate 			= V.k_rileyFireRate
		self.hp 				= 1

		self.gfx 				= gfx_riley
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 24
	elseif unitType == 2 then -- dulce/drone, homing fire 
		self.unitType			= 'dulce'
		self.w 					= 100
		self.h 					= 48
		self.fireRate 			= V.k_dulceFireRate
		self.hp 				= 1

		velocity 				= V.k_dulceVelo

		self.gfx 				= gfx_dulce
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 3 then -- augustus/frigate
		self.unitType			= 'augustus'
		self.w 					= 72
		self.h 					= 72
		self.fireRate 			= V.k_augustusFireRate
		self.hp 				= 2

		self.gfx 				= gfx_augustus
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 4 then -- hammerhead/sidefire
		self.unitType			= 'hammerhead'
		self.w 					= 96
		self.h 					= 144
		self.fireRate 			= V.k_hammerheadFireRate
		self.hp 				= 2

		self.gfx 				= gfx_hammerhead
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	elseif unitType == 5 then -- koltar/boss, 4-direction rapid shot
		self.unitType			= 'koltar'
		self.w 					= 160
		self.h 					= 48
		self.fireRate 			= V.k_koltarFireRate
		self.hp 				= 3
		self.spec 				= {oddShot = true}

		self.gfx 				= gfx_koltar
		self.throttle_gfx 		= gfx_throttle1
		self.throttle_dist		= 46
	end

	self.x 					= x
	self.y 					= y
	self.r 					= r
	self.lifetime 			= 0
	self.reloadProcess 		= self.fireRate

	-- local velo_x = velo_x or 0
	-- self.velo.x = velo_x
	-- local velo_y = velo_y or V.k_defaultVeloY
	-- self.velo.y = velo_y



	self.velo.x = velocity * math.cos(r)
	self.velo.y = velocity * math.sin(r)

	self.alive 	= true
	self.exists = true
end