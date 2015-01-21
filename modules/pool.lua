Pool = {}

function Pool:init()

	-- Keadani base, hostiles
	self.keadani = {}
	for i = 1, 50 do
		local keadani = Keadani()
		table.insert(Pool.keadani, keadani)
	end

	-- Meteor, neutral, natural hazard
	self.meteor = {}
	for i = 1, 50 do
		local meteor = Meteor()
		table.insert(Pool.meteor, meteor)
	end

	-- Bullet base
	self.bullet = {}
	for i = 1, 100 do
		local bullet = Bullet()
		table.insert(Pool.bullet, bullet)
	end

	-- Dust
	self.dust = {}
	for i = 1, 2000 do
		local dust = Dust()
		table.insert(Pool.dust, dust)
	end

	-- tunnel light
	self.light = {}
	for i = 1, 20 do
		local light = Light()
		table.insert(self.light, light)
	end
	
end

function Pool:update(dt)
	
end

function Pool:draw()

end