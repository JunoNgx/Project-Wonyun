-- Roadie handles things below the main playground
Roadie = {}

function Roadie:init()
	self.b1 = {}
	initStars()
end

function Roadie:update(dt)
	for i, object in ipairs(self.b1) do
		if not object.exists then
			table.remove(self.b1, i)
		else
			object:update(dt)
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
	-- for i = 1, #self.b1 do
	-- 	self.b1[i]:draw()
	-- end
end