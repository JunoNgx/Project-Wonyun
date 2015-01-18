Keadani = Class {}

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
	-- self.reloadProcess = V.e_fighterFireRate

	self.velo = {
		x = 0,
		y = 0,
	}

	self.alive 	= false
	self.exists = false

	-- self.gfx = loader.Image.fighter
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
		
			self.x = self.x + self.velo.x * dt
			self.y = self.y + self.velo.y * dt

			if self.x < 0 - V.gameplayMargin or self.x > gRes.w + V.gameplayMargin then self:finishKill() end
			if self.y < 0 - V.gameplayMargin or self.y > gRes.h + V.gameplayMargin then self:finishKill() end
		end
	end
end

function Keadani:draw()
	if self.exists then
		love.graphics.setColor(255,255,255,255)
		Jutils.draw(self.gfx, self.x, self.y, self.r)

		if G.debugMode then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)

			love.graphics.setColor(255,255,255)
			love.graphics.print(self.velo.y, self.x + 32, self.y)
		end
	end
end

--------------------------------

function Keadani:hit()
	self:kill()
end

function Keadani:kill()
	self.alive = false
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
		self.w 					= 48
		self.h 					= 48
		self.fireRate 			= V.k_rileyFireRate

		self.gfx 				= gfx_riley
	elseif unitType == 2 then -- augustus/frigate
		self.w 					= 52
		self.h 					= 64
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_augustus
	elseif unitType == 3 then -- dulce/drone, homing fire
		self.w 					= 36
		self.h 					= 36
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_dulce
	elseif unitType == 4 then -- hammerhead/sidefire
		self.w 					= 48
		self.h 					= 48
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_hammerhead
	elseif unitType == 5 then -- koltar/boss, 8-direction shot
		self.w 					= 48
		self.h 					= 48
		self.fireRate 			= V.k_defaultFireRate

		self.gfx 				= gfx_koltar
	end

	self.reloadProcess 		= self.fireRate
	self.x 					= x
	self.y 					= y
	self.lifetime 			= 0

	local velo_x = velo_x or 0
	self.velo.x = velo_x
	local velo_y = velo_y or V.k_defaultVeloY
	self.velo.y = velo_y
	-- local extraVelo_y = extraVelo_y or 0
	-- self.velo.y = self.velo.y + extraVelo_y

	self.alive 	= true
	self.exists = true
end