Meteor = Class {}

function spawnMeteor(x, y, r, velo, scaleSize)
	local meteor = Pool.meteor[1]

	meteor:spawn(x, y, r, velo, scaleSize)

	table.insert(Director.alive, meteor)
	table.remove(Pool.meteor, 1)
end

function Meteor:init()

	self.baseid 	= 'meteor'
	self.objType 	= 'vessel'

	self.typeid 	= 'meteor'
	self.alliance 	= 'neutral'

	self.x 			= 0
	self.y 			= 0
	-- self.w 			= 48
	-- self.h 			= 48
	self.r 			= 0
	self.lifetime 	= 0
	self.velo 		= {x = 0, y = 0}

	self.emitProcess = 0

	self.alive 		= false
	self.exists 	= false

	self.gfx = gfx_meteor
end

function Meteor:update(dt)
	if self.exists then

		self.lifetime = self.lifetime + dt

		if self.alive then

			updateVelocity(self, dt)

			if self.emitProcess < 0 then
				local dist_x = self.w/2 * math.cos(self.r)
				local dist_y = self.h/2 * math.sin(self.r)
				spawnDust(self.x - dist_x,
					self.y - dist_y,
					self.r - math.pi,
					self.w/1.5,
					3)
				self.emitProcess = V.m_emitRate
			else
				self.emitProcess = self.emitProcess - dt
			end

			if outOfBounds(self) then self:finishKill() end
		end
	end
end

function Meteor:draw()
	love.graphics.setColor(255,255,255)
	Jutils.draw(self.gfx, self.x, self.y, self.r, self.scale, self.scale)

	if G.debugMode then
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255,0,0,255)
		love.graphics.rectangle('line', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
		-- love.graphics.print(self.alliance, self.x + 16, self.y)
	end
end

function Meteor:hit(damage)
	self:kill()
end

function Meteor:kill()
	self.alive = false
	self:finishKill()
	
	spawnExplosion(self.x, self.y, 3, 2)
	Camera:shake(7, 0.2)
end

function Meteor:finishKill()
	self.alive = false
	self.exists = false
end

function Meteor:spawn(x, y, r, velo, scaleSize)
	self.x = x
	self.y = y
	local scaleSize = scaleSize or 1
	self.scale = scaleSize
	self.w = V.m_defaultSize * scaleSize
	self.h = V.m_defaultSize * scaleSize
	self.r = r

	local velo = velo or V.m_defaultVelo
	self.velo.x = velo * math.cos(r)
	self.velo.y = velo * math.sin(r)

	self.lifetime = 0
	self.alive = true
	self.exists = true
end