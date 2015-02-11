Assistant = {}

function Assistant:init()
	self.t1 = {}
	self.t2 = {}
	-- initDust()
	-- initGust()
end

function Assistant:update(dt)
	-- for i = 1, #self.t1 do 
	-- 	if self.t1[i].exists then
	-- 		self.t1[i]:update(dt)
	-- 	else
	-- 		table.remove(self.t1, i)
	-- 	end
	-- end

	for i, object in ipairs(self.t1) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'dust' then
				table.insert(Pool.dust, object)
			end
			table.remove(self.t1, i)
		end
	end

	for i, object in ipairs(self.t2) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'explosion' then
				table.insert(Pool.explosion, object)
			elseif object.typeid == 'fragment' then
				table.insert(Pool.fragment, object)
			end
			table.remove(self.t2, i)
		end
	end
end

function Assistant:draw()
	-- for i = 1, #self.t1 do
	-- 	self.t1[i]:draw()
	-- end
	for i, object in ipairs(self.t1) do
		object:draw()
	end
	for i, object in ipairs(self.t2) do
		object:draw()
	end
end
