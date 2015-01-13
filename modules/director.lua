Director = {
	-- alive = {},
}

function Director:init()
	Director.alive = {}
end

function Director:update(dt)
	for i, entity in ipairs(Director.alive) do
		entity:update(dt)
		if not entity.exists then
			if entity.typeid == 'bullet_f' then
				table.insert(Pool.bullet_f, entity)
			end
			table.remove(Director.alive, i)
		end
	end


	-- for i = 1, #Director.alive do
	-- 	Director.alive[i]:update(dt)

	-- 	if not Director.alive[i].alive then
	-- 		if Director.alive[i].typeid == 'bullet_f' then
	-- 			table.insert(Pool.bullet_f, Director.alive[i])
	-- 		end
	-- 		table.remove(Director.alive, i)
	-- 	end
	-- end
end

function Director:drawEntities()
	for i = 1, #Director.alive do
		Director.alive[i]:draw()
	end
end

function spawnBullet_f(r)
	local r = r or -math.pi/2
	local bullet_f = Pool.bullet_f[1]

	bullet_f:spawn(p.x, p.y - 32, r)

	table.insert(Director.alive, bullet_f)
	table.remove(Pool.bullet_f, 1)
end