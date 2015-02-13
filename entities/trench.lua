Trench = Class {}

function spawnTrench(alignment, layer)
	local trench = Pool.trench[1]

	trench:spawn(alignment, layer)

	if layer == 1 then
		table.insert(Roadie.t1, trench)
	elseif layer == 2 then
		table.insert(Roadie.t2, trench)
	elseif layer == 3 then
		table.insert(Roadie.t3, trench)
	elseif layer == 4 then
		table.insert(Roadie.t4, trench)
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
	self.layer = nil
	self.hParalMod = nil
	self.hParal_xMod = 0 -- modification to self.x as a result of horizontal parallax
	self.alignment = nil

	self.exists = false
end

function Trench:update(dt)
	if self.exists then
		updateVelocity(self, dt)

		-- Horitonzal parallax
		 self.hParal_xMod = Camera.x * self.hParalRate

		if outOfBounds(self) then self:kill() end
	end
end

function Trench:draw()
	-- Colors
	if self.layer == 1 then
		love.graphics.setColor(45,45,45)
	elseif self.layer == 2 then
		love.graphics.setColor(60,60,60)
	elseif self.layer == 3 then
		love.graphics.setColor(80,80,80)
	elseif self.layer == 4 then
		love.graphics.setColor(100,100,100)
	end
	
	love.graphics.polygon('fill',
		self.x + self.hParal_xMod + self.vertex[1], self.y + self.vertex[2],
		self.x + self.hParal_xMod + self.vertex[3], self.y + self.vertex[4],
		self.x + self.hParal_xMod + self.vertex[5], self.y + self.vertex[6],
		self.x + self.hParal_xMod + self.vertex[7], self.y + self.vertex[8]
		)
end

function Trench:spawn(alignment, layer)

	-- Randomized towards center of the gameplay ground
	if alignment == 'l' then

		self.x = 0
		self.y = -300

		self.vertex[1] = -400
		self.vertex[2] = -80


		if layer == 1 then
			self.vertex[3] = love.math.random(V.t_x1_1, V.t_x1_2)
		elseif layer == 2 then
			self.vertex[3] = love.math.random(V.t_x2_1, V.t_x2_2)
		elseif layer == 3 then
			self.vertex[3] = love.math.random(V.t_x3_1, V.t_x3_2)
		elseif layer == 4 then
			self.vertex[3] = love.math.random(V.t_x4_1, V.t_x4_2)
		end
		self.vertex[4] = -80


		if layer == 1 then
			self.vertex[5] = love.math.random(V.t_x1_1, V.t_x1_2)
		elseif layer == 2 then
			self.vertex[5] = love.math.random(V.t_x2_1, V.t_x2_2)
		elseif layer == 3 then
			self.vertex[5] = love.math.random(V.t_x3_1, V.t_x3_2)
		elseif layer == 4 then
			self.vertex[5] = love.math.random(V.t_x4_1, V.t_x4_2)
		end
		self.vertex[6] = 80

		self.vertex[7] = -400
		self.vertex[8] = 80

		self.alignment = 'l'
		-- self.hParalDir = 1

	elseif alignment == 'r' then

		self.x = gRes.w
		self.y = -300 

		if layer == 1 then
			self.vertex[1] = love.math.random(-V.t_x1_2, -V.t_x1_1)
		elseif layer == 2 then
			self.vertex[1] = love.math.random(-V.t_x2_2, -V.t_x2_1)
		elseif layer == 3 then
			self.vertex[1] = love.math.random(-V.t_x3_2, -V.t_x3_1)
		elseif layer == 4 then
			self.vertex[1] = love.math.random(-V.t_x4_2, -V.t_x4_1)
		end
		self.vertex[2] = -80

		self.vertex[3] = 400
		self.vertex[4] = -80


		self.vertex[5] = 400
		self.vertex[6] = 80

		if layer == 1 then
			self.vertex[7] = love.math.random(-V.t_x1_2, -V.t_x1_1)
		elseif layer == 2 then
			self.vertex[7] = love.math.random(-V.t_x2_2, -V.t_x2_1)
		elseif layer == 3 then
			self.vertex[7] = love.math.random(-V.t_x3_2, -V.t_x3_1)
		elseif layer == 4 then
			self.vertex[7] = love.math.random(-V.t_x4_2, -V.t_x4_1)
		end
		self.vertex[8] = 80

		self.alignment = 'r'
		-- self.hParalDir = -1
	end

	-- Vertical parallax
	if layer == 1 then
		self.layer = 1
		self.velo.y = V.t_velo1
		self.hParalRate = V.t_hParalRate1
	elseif layer == 2 then
		self.layer = 2
		self.velo.y = V.t_velo2
		self.hParalRate = V.t_hParalRate2
	elseif layer == 3 then
		self.layer = 3
		self.velo.y = V.t_velo3
		self.hParalRate = V.t_hParalRate3
	elseif layer == 4 then
		self.layer = 4
		self.velo.y = V.t_velo4
		self.hParalRate = V.t_hParalRate4
	end

	self.exists = true
end

function Trench:kill()
	self.exists = false
end