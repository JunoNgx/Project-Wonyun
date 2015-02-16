Fragment = Class {}

function spawnFragment(x, y, r, dustColor)
	local fragment = Pool.fragment[1]

	fragment:spawn(x, y, r, dustColor)

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
	self.dustColor = 0

	self.gfx = gfx_fragment
end

function Fragment:update(dt)
	if self.exists then 
		updateVelocity(self, dt)
		self.lifetime = self.lifetime + dt
		self.r_display = self.r_display + dt * self.turnSpeed

		if self.lifetime > self.maxLifetime then self:kill() end

		spawnDust(self.x, self.y, self.r - math.pi, 20, self.dustColor)

		-- if self.isPlayer then
		-- 	spawnDust(self.x, self.y, self.r - math.pi, 20, self.dustColor)
		-- else
		-- 	spawnDust(self.x, self.y, self.r - math.pi, 20, 2)
		-- end
	end
end

function Fragment:draw()
	-- love.graphics.setColor(240,120,120)
	love.graphics.setColor(70,70,70)
	Jutils.draw(self.gfx, self.x, self.y, self.r_display)
end

function Fragment:spawn(x, y, r, dustColor)

	self.x = x
	self.y = y
	self.r = r

	self.dustColor = dustColor

	local velo = love.math.random(V.f_minVelo, V.f_maxVelo)
	self.velo.x = velo * math.cos(r)
	self.velo.y = velo * math.sin(r)

	self.lifetime = 0
	self.emitProcess = 0

	self.r_display = r
	self.turnSpeed = love.math.random(20,50)/10

	-- local isPlayer = isPlayer or false
	-- if isPlayer then
	-- 	self.isPlayer = true
	-- else
	-- 	self.isPlayer = false
	-- end

	self.exists = true
end

function Fragment:kill()
	self.exists = false
end