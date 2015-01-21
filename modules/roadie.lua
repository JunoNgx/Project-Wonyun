-- Roadie handles things below the main playground
Roadie = {}

function Roadie:init()
	self.b1 = {}
	self.b2 = {}
	self.b3 = {}
	initStars()

end

function Roadie:update(dt)
	for i, object in ipairs(self.b1) do
		if object.exists then
			object:update(dt)
		else
			table.remove(self.b1, i)
		end
	end

	for i, object in ipairs(self.b2) do
		if object.exists then
			object:update(dt)
		else
			table.remove(self.b2, i)
		end
	end

	for i, object in ipairs(self.b3) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'light' then 
				table.insert(Pool.light, object)
			end
			table.remove(self.b3, i)
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
	for i, object in ipairs(self.b1) do
		object:draw()
	end

	for i, object in ipairs(self.b2) do
		object:draw()
	end

	for i, object in ipairs(self.b3) do
		object:draw()
	end
	-- for i = 1, #self.b1 do
	-- 	self.b1[i]:draw()
	-- end
end