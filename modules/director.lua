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
			-- Alive entity removal codes here --

			if entity.typeid == 'bullet_f' then
				table.insert(Pool.bullet_f, entity)
			end

			if entity.typeid == 'fighter' then
				table.insert(Pool.fighter, entity)
			end

			if entity.typeid == 'bullet_e' then
				table.insert(Pool.bullet_e, entity)
			end

			-- Removal codes ends here --
			table.remove(Director.alive, i)
		end
		
	end
end

function Director:updateCollision(dt)
	for i, hittingEntity in ipairs(Director.alive) do
		for i, hitEntity in ipairs(Director.alive) do
			if hittingEntity ~= hitEntity then
				if IsColliding(hittingEntity, hitEntity) then
					
					collided = true
				else
					collided = false

				end
			end
		end
	end
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

function spawnFighter(x, y, r)
	local r = r or math.pi/2
	local fighter = Pool.fighter[1]

	fighter:spawn(x, y, r)

	table.insert(Director.alive, fighter)
	table.remove(Pool.fighter, 1)
end

function spawnBullet_e(x, y, r)
	local r = r or math.pi/2
	local bullet_e = Pool.bullet_e[1]

	bullet_e:spawn(x, y, r)

	table.insert(Director.alive, bullet_e)
	table.remove(Pool.bullet_e, 1)
end