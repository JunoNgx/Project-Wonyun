Light = Class {}

function spawnLight()
	local light = Pool.light[1]

	light:spawn()

	table.insert(Roadie.b3, light)
	table.remove(Pool.light, 1)
end

function Light:init()
	self.baseid = 'light'
	self.typeid = 'light'
	self.objType = 'decorBack'

	self.x = 0
	self.y = 0
	self.velo = {x = 0, y = 0}

	self.exists = 0

	self.gfx = gfx_light
end

function Light:update(dt)
	updateVelocity(self, dt)

	if outOfBounds(self) then self:kill() end
end

function Light:draw()
	love.graphics.setColor(255, 255, 255)
	Jutils.draw(self.gfx, self.x, self.y)
end

function Light:kill()
	self.exists = false
end

function Light:spawn()
	self.x = gRes.w/2
	self.y = 0 - 300

	self.velo.y = V.l_veloY

	self.exists = true	
end

