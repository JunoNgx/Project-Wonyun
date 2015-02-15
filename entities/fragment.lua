Fragment = Class {}

function spawnFragment(x, y, r)
	local fragment = Pool.fragment[1]

	fragment:spawn(x, y, r)

	table.insert(Assistant.fragment, fragment)
	table.remove(Pool.fragment, 1)
end

function Fragment:init()

	self.baseid = 'fragment'
	self.typeid = 'fragment'
	self.objType = 'decorTop'

	self.x = 0
	self.y = 0
	self.r = 0
	-- self.scale = 1
	self.velo = {x = 0, y = 0}

	self.exists = false

	self.lifetime = 0
	self.maxLifetime = love.math.random(V.f_minmaxLifetime, V.f_maxmaxLifetime)/10
	self.emitProcess = 0

	self.r_display = 0
	self.turnSpeed = love.math.random(V.f_minturnSpeed, V.f_maxturnSpeed)/10

	self.gfx = gfx_fragment
end

function Fragment:update(dt)
	if self.exists then 
		updateVelocity(self, dt)
		self.lifetime = self.lifetime + dt
		self.r_display = self.r_display + dt * self.turnSpeed

		if self.lifetime > self.maxLifetime then self:kill() end

		-- if self.emitProcess < 0 then
			spawnDust(self.x, self.y, self.r - math.pi, 20, true)
		-- 	self.emitProcess = V.f_emitRate
		-- else
		-- 	self.emitProcess = self.emitProcess - dt
		-- end
	end
end

function Fragment:draw()
	-- love.graphics.setColor(240,120,120)
	love.graphics.setColor(70,70,70)
	Jutils.draw(self.gfx, self.x, self.y, self.r_display)
end

function Fragment:spawn(x, y, r)
	self.x = x
	self.y = y
	self.r = r
	local velo = love.math.random(V.f_minVelo, V.f_maxVelo)
	self.velo.x = velo * math.cos(r)
	self.velo.y = velo * math.sin(r)

	self.lifetime = 0
	self.emitProcess = 0

	self.r_display = r
	self.turnSpeed = love.math.random(20,50)/10

	self.exists = true
end

function Fragment:kill()
	self.exists = false
end