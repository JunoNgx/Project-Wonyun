Carcass = Class {}

function spawnCarcass()
	local carcass = Pool.carcass[1]

	carcass:spawn()

	table.insert(Roadie.carcass, carcass)
	table.remove(Pool.carcass, 1)
end

function Carcass:init()

	self.baseid = 'carcass'
	self.typeid = 'carcass'
	self.objType = 'decorBack'

	self.x = 0
	self.y = 0
	self.r = 0
	-- self.scale = 1
	self.velo = {x = 0, y = 0}

	self.exists = false

	self.r_display = 0
	self.turnSpeed = love.math.random(-1, 1)
end

function Carcass:update(dt)
	updateVelocity(self, dt)

	if outOfBounds(self) then self:finishKill() end
end

function Carcass:draw()
	love.graphics.setColor(255, 255, 255)
	Jutils.draw(self.gfx, self.x, self.y)
end

function Carcass:finishKill()
	self.exists = false
end

function Carcass:spawn()
	self.x = love.math.random(0, gRes.w)
	self.y = 300

	self.velo.y = V.c_velo

	self.gfx = gfx_carcass[love.math.random(1,7)]

	self.exists = true	
end