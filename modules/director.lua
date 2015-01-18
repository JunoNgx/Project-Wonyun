Director = {
	-- alive = {},
}

function Director:init()
	Director.alive = {}
	Director.distanceTravelled = 0
end

-- self mechanic update
function Director:update(dt)
	Director.distanceTravelled = Director.distanceTravelled + dt * 420
end

-- Entities update
function Director:updateEntities(dt)
	for i, entity in ipairs(Director.alive) do
		entity:update(dt)

		if not entity.exists then
			-- Alive entity removal codes here --

			-- if entity.typeid == 'bullet_f' then
			-- 	table.insert(Pool.bullet_f, entity)
			-- end

			if entity.baseid == 'keadani' then
				table.insert(Pool.keadani, entity)
			end

			-- if entity.typeid == 'bullet_e' then
			-- 	table.insert(Pool.bullet_e, entity)
			-- end

			if entity.baseid == 'bullet' then
				table.insert(Pool.bullet, entity)
			end

			-- Removal codes ends here --
			table.remove(Director.alive, i)
		end
		
	end
end

function Director:updateCollision(dt)
	for i, entity in ipairs(Director.alive) do

		-- Player hit by other things
		if entity.typeid == 'player' then
			for i, hitEntity in ipairs(Director.alive) do
				if entity ~= hitEntity and IsColliding(entity, hitEntity) then
					if hitEntity.alliance ~= 'friendly' then

						entity:hit()
						hitEntity:hit()
					end
				end
			end
		end

		-- Friendly bullets hit others
		if entity.typeid == 'bullet_f' then
			for i, hitEntity in ipairs(Director.alive) do
				if entity ~= hitEntity and IsColliding(entity, hitEntity) then
					if hitEntity.objType == 'vessel' and hitEntity.alliance ~= 'friendly' then

						entity:hit()
						hitEntity:hit()
					end
				end
			end
		end


		-- if entity.typeid == 'player' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and IsColliding(entity, hitEntity) then
		-- 			if hitEntity.faction ~= 'friendly' then

		-- 				entity:finishKill()
		-- 				hitEntity:finishKill()
		-- 			end
		-- 		end
		-- 	end
		-- end

	end
end



-- ================== --
-- Spawning functions --
-- ================== --



function Director:drawEntities()
	for i = 1, #Director.alive do
		Director.alive[i]:draw()
	end
end

function Director:drawUI()
	love.graphics.setColor(255,255,255)
	Jutils.print(humanizeCounter(math.floor(Director.distanceTravelled)),
		0.5, 0.05, counterFont, true)
end

-- ================== --
-- Spawning functions --
-- ================== --

-- function spawnBullet_f(r)
-- 	local r = r or -math.pi/2
-- 	local bullet_f = Pool.bullet_f[1]

-- 	bullet_f:spawn(p.x, p.y - 32, r)
-- 	-- love.audio.play(sfx_pFire)

-- 	table.insert(Director.alive, bullet_f)
-- 	table.remove(Pool.bullet_f, 1)
-- end

function spawnKeadani(unitType, x, y, velo_x, velo_y)
	-- local r = r or math.pi/2
	local keadani = Pool.keadani[1]
	local unitType = unitType

	keadani:spawn(unitType, x, y, velo_x, velo_y)

	table.insert(Director.alive, keadani)
	table.remove(Pool.keadani, 1)
end

-- function spawnBullet_e(x, y, velo_x, velo_y)
-- 	-- local r = r or math.pi/2
-- 	local bullet_e = Pool.bullet_e[1]

-- 	bullet_e:spawn(x, y, velo_x, velo_y)
-- 	-- love.audio.play(sfx_eFire)

-- 	table.insert(Director.alive, bullet_e)
-- 	table.remove(Pool.bullet_e, 1)
-- end

function spawnBullet(alliance, x, y, velo_x, velo_y)
	local bullet = Pool.bullet[1]

	bullet:spawn(alliance, x, y, velo_x, velo_y)
	-- love.audio.play(sfx_eFire)

	table.insert(Director.alive, bullet)
	table.remove(Pool.bullet, 1)
end

-- =============== --
-- Utitlities func --
-- =============== --

function humanizeCounter(nummer)
	if nummer > 1000 then
		local part1 = tostring(math.floor(nummer/1000))
		local part2 = nummer % 1000
		if part2 < 10 then
			part2 = '00'..tostring(part2)
		elseif part2 < 100 then
			part2 = '0'..tostring(part2)
		elseif part2 < 1000 then
			part2 = tostring(part2)
		end
		
		return tostring(part1..','..part2)
	else
		return tostring(nummer)
	end
end