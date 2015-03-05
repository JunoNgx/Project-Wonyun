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

	-- explosion
	self.explosion = {}
	for i = 1, 40 do
		local explosion = Explosion()
		table.insert(self.explosion, explosion)
	end

	self.fragment = {}
	for i = 1, 50 do
		local fragment = Fragment()
		table.insert(self.fragment, fragment)
	end

	self.trench = {}
	for i = 1, 200 do
		local trench = Trench()
		table.insert(self.trench, trench)
	end

	self.drone = {}
	for i = 1, 400 do
		local drone = Drone()
		table.insert(self.drone, drone)
	end

	self.carcass = {}
	for i = 1, 32 do
		local carcass = Carcass()
		table.insert(self.carcass, drone)
	end
	
end

function Pool:update(dt)
	
end

function Pool:draw()

end