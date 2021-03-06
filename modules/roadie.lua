-- Roadie handles things below the main playground
Roadie = {}

function Roadie:init()
	self.light = {}
	self.star = {}
	self.trench1 = {}
	self.trench2 = {}
	self.trench3 = {}
	self.carcass = {}
	self.trench4 = {}
	initStars()

end

function Roadie:update(dt)
	for i, object in ipairs(self.light) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'light' then 
				table.insert(Pool.light, object)
			end
			table.remove(self.light, i)
		end
	end

	for i, object in ipairs(self.star) do
		if object.exists then
			object:update(dt)
		else
			-- table.remove(self.star, i)
		end
	end


	for i, object in ipairs(self.trench1) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'trench' then
				table.insert(Pool.trench, object)
			end
			table.remove(self.trench1, i)
		end
	end

	for i, object in ipairs(self.trench2) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'trench' then
				table.insert(Pool.trench, object)
			end
			table.remove(self.trench2, i)
		end
	end

	for i, object in ipairs(self.trench3) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'trench' then
				table.insert(Pool.trench, object)
			end
			table.remove(self.trench3, i)
		end
	end

	for i, object in ipairs(self.carcass) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'carcass' then
				table.insert(Pool.carcass, object)
			end
			table.remove(self.carcass, i)
		end
	end

	for i, object in ipairs(self.trench4) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'trench' then
				table.insert(Pool.trench, object)
			end
			table.remove(self.trench4, i)
		end
	end
	-- for i = 1, #self.b1 do
	-- 	if self.b1[i].exists then
	-- 		self.b1[i]:update(dt)
	-- 	else
	-- 		table.remove(self.b1, i)
	-- 	end
	-- end
end

function Roadie:draw()
	for i, object in ipairs(self.star) do
		object:draw()
	end	

	for i, object in ipairs(self.light) do
		object:draw()
	end

	for i, object in ipairs(self.trench1) do
		object:draw()
	end

	for i, object in ipairs(self.trench2) do
		object:draw()
	end

	for i, object in ipairs(self.trench3) do
		object:draw()
	end	

	for i, object in ipairs(self.carcass) do
		object:draw()
	end	

	for i, object in ipairs(self.trench4) do
		object:draw()
	end
	-- for i = 1, #self.b1 do
	-- 	self.b1[i]:draw()
	-- end
end