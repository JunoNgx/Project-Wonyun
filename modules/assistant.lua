Assistant = {}

function Assistant:init()
	self.fragment = {}
	self.t1 = {}
	self.t2 = {}
	-- initDust()
	-- initGust()
	self.trench4 = {}
end

function Assistant:update(dt)
	-- for i = 1, #self.t1 do 
	-- 	if self.t1[i].exists then
	-- 		self.t1[i]:update(dt)
	-- 	else
	-- 		table.remove(self.t1, i)
	-- 	end
	-- end

	for i, object in ipairs(self.fragment) do
		if object.exists then
			object:update(dt)
		else
			if object.typeid == 'fragment' then
				table.insert(Pool.fragment, object)			
			end
			table.remove(self.fragment, i)
		end
	end

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
			-- elseif object.typeid == 'fragment' then
			-- 	table.insert(Pool.fragment, object)
			end
			table.remove(self.t2, i)
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

end

function Assistant:draw()
	-- for i = 1, #self.t1 do
	-- 	self.t1[i]:draw()
	-- end

	for i, object in ipairs(self.fragment) do
		object:draw()
	end

	for i, object in ipairs(self.t1) do
		object:draw()
	end

	for i, object in ipairs(self.t2) do
		object:draw()
	end

	for i, object in ipairs(self.trench4) do
		object:draw()
	end
end
