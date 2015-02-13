Trench = Class {}

function spawnTrench(alignment, layer)
	local trench = Pool.trench[1]

	trench:spawn(alignment, layer)

	if layer == 3 then
		table.insert(Roadie.b3, trench)
	elseif layer == 2 then
		table.insert(Roadie.b2, trench)
	elseif layer == 1 then
		table.insert(Roadie.b1, trench)
	end
	table.remove(Pool.trench, 1)
end

function Trench:init()

	self.baseid = 'trench'
	self.typeid = 'trench'
	self.objType = 'decorBack'

	self.x = 0
	self.y = 0

	self.velo = {x = 0, y = 0}

	self.vertex = {0,0, 0,0, 0,0, 0,0}
	self.col = {0, 0, 0, 0}
	self.layer = 0

	self.exists = false
end

function Trench:update(dt)
	if self.exists then
		updateVelocity(self, dt)

		if outOfBounds(self) then self:kill() end
	end
end

function Trench:draw()
	if self.layer == 1 then
		love.graphics.setColor(30,30,30)
	elseif self.layer == 2 then
		love.graphics.setColor(60,60,60)
	elseif self.layer == 3 then
		love.graphics.setColor(80,80,80)
	end
	
	love.graphics.polygon('fill',
		self.x + self.vertex[1], self.y + self.vertex[2],
		self.x + self.vertex[3], self.y + self.vertex[4],
		self.x + self.vertex[5], self.y + self.vertex[6],
		self.x + self.vertex[7], self.y + self.vertex[8]
		)
end

function Trench:spawn(alignment, layer)
	if alignment == 'l' then

		self.x = 0
		self.y = -300

		self.vertex[1] = -20
		self.vertex[2] = -80


		if layer == 3 then
			self.vertex[3] = love.math.random(60,100)
		elseif layer == 2 then
			self.vertex[3] = love.math.random(100,140)
		elseif layer == 1 then
			self.vertex[3] = love.math.random(140,180)
		end
		self.vertex[4] = -80


		if layer == 3 then
			self.vertex[5] = love.math.random(60,100)
		elseif layer == 2 then
			self.vertex[5] = love.math.random(100,140)
		elseif layer == 1 then
			self.vertex[5] = love.math.random(140,180)
		end
		self.vertex[6] = 80

		self.vertex[7] = -20
		self.vertex[8] = 80

	elseif alignment == 'r' then

		self.x = gRes.w
		self.y = -300 

		if layer == 3 then
			self.vertex[1] = love.math.random(-100,-60)
		elseif layer == 2 then
			self.vertex[1] = love.math.random(-140,-100)
		elseif layer == 1 then
			self.vertex[1] = love.math.random(-180,-140)
		end
		self.vertex[2] = -80

		self.vertex[3] = 20
		self.vertex[4] = -80


		self.vertex[5] = 20
		self.vertex[6] = 80

		if layer == 3 then
			self.vertex[7] = love.math.random(-100,-60)
		elseif layer == 2 then
			self.vertex[7] = love.math.random(-140,-100)
		elseif layer == 1 then
			self.vertex[7] = love.math.random(-180,-140)
		end
		self.vertex[8] = 80
	end

	if layer == 1 then
		self.velo.y = V.t_velo1
		self.layer = 1
	elseif layer == 2 then
		self.velo.y = V.t_velo2
		self.layer = 2
	elseif layer == 3 then
		self.velo.y = V.t_velo3
		self.layer = 3
	end

	self.exists = true
end

function Trench:kill()
	self.exists = false
end