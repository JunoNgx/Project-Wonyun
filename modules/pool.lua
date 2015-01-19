Pool = {}

function Pool:init()

	-- Keadani base, hostiles
	self.keadani = {}
	for i = 1, 100 do
		local keadani = Keadani()
		table.insert(Pool.keadani, keadani)
	end

	-- Bullet base
	self.bullet = {}
	for i = 1, 100 do
		local bullet = Bullet()
		table.insert(Pool.bullet, bullet)
	end
	
end

function Pool:update(dt)
	
end

function Pool:draw()

end