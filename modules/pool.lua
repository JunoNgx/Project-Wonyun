-- require 'entities/bullet_f'

Pool = {
	-- bullet_f = {},
	-- fighter = {},
	-- bullet_e = {},
	
}

function Pool:init()
	-- bullet_f
	self.bullet_f = {}
	for i = 1, 20 do
		local bullet_f = Bullet_f()
		table.insert(Pool.bullet_f, bullet_f)
	end

	-- enemy fighters
	self.fighter = {}
	for i = 1, 20 do
		local fighter = Fighter()
		table.insert(Pool.fighter, fighter)
	end

	-- bullet_e
	self.bullet_e = {}
	for i = 1, 50 do
		local bullet_e = Bullet_e()
		table.insert(Pool.bullet_e, bullet_e)
	end
end

function Pool:update(dt)
	
end

function Pool:draw()

end