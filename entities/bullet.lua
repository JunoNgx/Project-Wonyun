Bullet = Class {}

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
	if self.exists then
		if self.alliance == 'friendly' then
			love.graphics.setColor(255,0,0,255)
			Jutils.draw(self.gfx, self.x, self.y, self.r)
		elseif self.alliance == 'hostile' then
			-- love.graphics.setColor(140,200,220,255)
			love.graphics.setColor(50,80,150,255)
			Jutils.draw(self.gfx, self.x, self.y)
		elseif self.alliance == 'neutral' then
			love.graphics.setColor(250,240,120,255)
			Jutils.draw(self.gfx, self.x, self.y)
		end

		if G.debugMode then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
			love.graphics.print(self.alliance, self.x + 16, self.y)
		end
	end
end

------------------------------------

function Bullet:hit()
	self:kill()
end

function Bullet:kill()
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

	self.x 			= x
	self.y 			= y
	self.lifetime 	= 0
	self.velo.x 	= velo_x or 0

	self.alive 		= true
	self.exists 	= true
end

-----------------------------------

-- Prototype feature: capturing non-friendly bullets to replenish ammo

function Bullet:captured()
	self.alliance 	= 'captured'
	self.velo 		= {x = 0, y = 0}
end

function Bullet:moveTo(des_x, des_y)
	local r = lume.angle(self.x, self.y, des_x, des_y)

	self.velo.x = V.b_captureVelo * math.cos(r)
	self.velo.y = V.b_captureVelo * math.sin(r)
end