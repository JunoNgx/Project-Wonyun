Bullet = Class {}

function spawnBullet(alliance, x, y, velo_x, velo_y)
	local bullet = Pool.bullet[1]

	bullet:spawn(alliance, x, y, velo_x, velo_y)
	-- love.audio.play(sfx_eFire)

	table.insert(Director.alive, bullet)
	table.remove(Pool.bullet, 1)
end

function Bullet:init()

	self.baseid = 'bullet'
	self.objType = 'bullet'

	self.typeid = 'undefinedBullet'
	self.alliance = 'undefinedAlliance'

	self.x = 0
	self.y = 0
	self.w = 16
	self.h = 16

	self.velo = {
		x = 0,
		y = 0,
	}
	self.r = -math.pi/2 -- temp

	self.lifetime = 0

	self.alive 	= false
	self.exists = false
end

function Bullet:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		if self.alive then
			updateVelocity (self, dt)

			-- if self.x < 0 - V.gameplayMargin or self.x > gRes.w + V.gameplayMargin then self:finishKill() end
			-- if self.y < 0 - V.gameplayMargin or self.y > gRes.h + V.gameplayMargin then self:finishKill() end

			if outOfBounds(self) then self:finishKill() end
		end
	end
end

function Bullet:draw()
	-- if self.exists then
	if self.alliance == 'friendly' then
		love.graphics.setColor(255,255,255,255)
		Jutils.draw(self.gfx, self.x, self.y, self.r)
	elseif self.alliance == 'hostile' then
		-- love.graphics.setColor(140,200,220,255)
		love.graphics.setColor(50,80,150,255)
		Jutils.draw(self.gfx, self.x, self.y)
	elseif self.alliance == 'neutral' then
		love.graphics.setColor(250,240,120,255)
		Jutils.draw(self.gfx, self.x, self.y)
	elseif self.alliance == 'captured' then
		love.graphics.setColor(250, 240, 90,255)
		Jutils.draw(self.gfx, self.x, self.y)
	end

	if G.debugMode then
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
		love.graphics.print(self.alliance, self.x + 16, self.y)
	end
	-- end
end

------------------------------------

function Bullet:hit(damage)
	self:kill()
end

function Bullet:kill()
	if self.alliance == 'friendly' then
		spawnExplosion(self.x, self.y, 3, 1) -- redBullet
	elseif self.alliance == 'hostile' then
		spawnExplosion(self.x, self.y, 1, 1) -- blueBullet
	elseif self.alliance == 'neutral' then
		spawnExplosion(self.x, self.y, 3, 1) -- coldBullet
	end

	self.alive = false
	self:finishKill()
end

function Bullet:finishKill()
	self.typeid 	= 'undefinedBullet'
	self.alliance 	= 'undefinedAlliance'

	self.velo 	= {x = 0, y = 0}

	self.alive 	= false
	self.exists = false
end

function Bullet:spawn(alliance, x, y, velo_x, velo_y)

	if alliance == 1 then -- friendly
		self.typeid 	= 'bullet_f'
		self.alliance 	= 'friendly'
		self.velo.y 	= velo_y or V.bf_veloY

		self.gfx = gfx_bullet_f
	elseif alliance == 2 then -- hostile
		self.typeid 	= 'bullet_e'
		self.alliance 	= 'hostile'
		self.velo.y 	= velo_y or V.be_veloY

		self.gfx = gfx_bullet_e
	elseif alliance == 3 then -- neutral
		self.typeid 	= 'bullet_n'
		self.alliance 	= 'neutral'
		self.velo.y 	= velo_y

		self.gfx = gfx_bullet_e
	end

	-- adjusting self.r for the sake of friendly bullets
	if alliance == 1 then
		self.r = lume.angle(0,0, velo_x, velo_y)
	else
		self.r = 0
	end

	self.x 			= x
	self.y 			= y
	self.velo.x 	= velo_x or 0

	self.lifetime 	= 0
	self.alive 		= true
	self.exists 	= true
end

-----------------------------------

-- Prototype feature: capturing non-friendly bullets to replenish ammo

function Bullet:captured()
	self.alliance 	= 'captured'
	self.typeid		= 'bullet_c'
	self.velo 		= {x = 0, y = 0}
end

function Bullet:moveTo(desObj)
	local r = lume.angle(self.x, self.y, desObj.x, desObj.y)

	self.velo.x = V.b_captureVelo * math.cos(r)
	self.velo.y = V.b_captureVelo * math.sin(r)
end