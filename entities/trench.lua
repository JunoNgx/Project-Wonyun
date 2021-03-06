Trench = Class {}

function spawnTrench(alignment, layer)
	local trench = Pool.trench[1]

	trench:spawn(alignment, layer)

	if layer == 1 then
		table.insert(Roadie.trench1, trench)
	elseif layer == 2 then
		table.insert(Roadie.trench2, trench)
	elseif layer == 3 then
		table.insert(Roadie.trench3, trench)
	elseif layer == 4 then
		table.insert(Assistant.trench4, trench)
		-- table.insert(Roadie.trench4, trench)
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
	love.graphics.setColor(self.col)
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

		self.vertex[1] = -V.t_length
		self.vertex[2] = -V.t_height


		if layer == 1 then
			self.vertex[3] = love.math.random(V.t_x1_1, V.t_x1_2)
		elseif layer == 2 then
			self.vertex[3] = love.math.random(V.t_x2_1, V.t_x2_2)
		elseif layer == 3 then
			self.vertex[3] = love.math.random(V.t_x3_1, V.t_x3_2)
		elseif layer == 4 then
			self.vertex[3] = love.math.random(V.t_x4_1, V.t_x4_2)
		end
		self.vertex[4] = -V.t_height


		-- if layer == 1 then
		-- 	self.vertex[5] = love.math.random(V.t_x1_1, V.t_x1_2)
		-- elseif layer == 2 then
		-- 	self.vertex[5] = love.math.random(V.t_x2_1, V.t_x2_2)
		-- elseif layer == 3 then
		-- 	self.vertex[5] = love.math.random(V.t_x3_1, V.t_x3_2)
		-- elseif layer == 4 then
		-- 	self.vertex[5] = love.math.random(V.t_x4_1, V.t_x4_2)
		-- end
		self.vertex[5] = self.vertex[3] - V.t_innerPointMod
		self.vertex[6] = V.t_height

		self.vertex[7] = -V.t_length
		self.vertex[8] = V.t_height

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
		self.vertex[2] = -V.t_height

		self.vertex[3] = V.t_length
		self.vertex[4] = -V.t_height


		self.vertex[5] = V.t_length
		self.vertex[6] = V.t_height

		-- if layer == 1 then
		-- 	self.vertex[7] = love.math.random(-V.t_x1_2, -V.t_x1_1)
		-- elseif layer == 2 then
		-- 	self.vertex[7] = love.math.random(-V.t_x2_2, -V.t_x2_1)
		-- elseif layer == 3 then
		-- 	self.vertex[7] = love.math.random(-V.t_x3_2, -V.t_x3_1)
		-- elseif layer == 4 then
		-- 	self.vertex[7] = love.math.random(-V.t_x4_2, -V.t_x4_1)
		-- end
		self.vertex[7] = self.vertex[1] + V.t_innerPointMod
		self.vertex[8] = V.t_height

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

	if G.hallucinativeMode then
		-- Color experimenting
		self.col = colorTrench[love.math.random(1,4)]
		if layer == 1 then
			-- for i = 1, 3 do self.col[i] = self.col[i] - 40 end
			self.col = colorTrench[1]
		elseif layer == 2 then
			-- for i = 1, 3 do self.col[i] = self.col[i] - 30 end
			self.col = colorTrench[2]
		elseif layer == 3 then
			-- for i = 1, 3 do self.col[i] = self.col[i] - 20 end
			self.col = colorTrench[3]
		elseif layer == 4 then
			-- for i = 1, 3 do self.col[i] = self.col[i] - 10 end
			self.col = colorTrench[4]
		end
	else
		-- Regular shades of grey
		if self.layer == 1 then
			self.col = {45,45,45}
		elseif self.layer == 2 then
			self.col = {60,60,60}
		elseif self.layer == 3 then
			self.col = {80,80,80}
		elseif self.layer == 4 then
			self.col = {100,100,100}
		end
	end


	self.exists = true
end

function Trench:kill()
	self.exists = false
end