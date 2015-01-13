-- require 'entities/bullet_f'

Pool = {
	bullet_f = {},
	-- alive = {},
}

function Pool:init()
	for i = 1, 20 do
		local bullet_f = Bullet_f()
		table.insert(Pool.bullet_f, bullet_f)
	end
end

function Pool:update(dt)
	-- for i, bullet_f in pairs(grpBullet_f.alive) do
	-- 	bullet_f:update(dt)
	-- end
end

function Pool:draw()

end