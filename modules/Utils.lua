-- ================== --
-- Spawning functions --
-- ================== --

function spawnKeadani(unitType, x, y, velo_x, velo_y)
	-- local r = r or math.pi/2
	local keadani = Pool.keadani[1]
	local unitType = unitType

	keadani:spawn(unitType, x, y, velo_x, velo_y)

	table.insert(Director.alive, keadani)
	table.remove(Pool.keadani, 1)
end


function spawnBullet(alliance, x, y, velo_x, velo_y)
	local bullet = Pool.bullet[1]

	bullet:spawn(alliance, x, y, velo_x, velo_y)
	-- love.audio.play(sfx_eFire)

	table.insert(Director.alive, bullet)
	table.remove(Pool.bullet, 1)
end

function initStars()
	for i = 1, 20 do
		local star = Star()

		star:reset()
		star:spread()
		table.insert(Roadie.alive, star)
	end
end

-- =============== --
-- Utitlities func --
-- =============== --

-- Regular velocity update
function updateVelocity(obj, dt)
	obj.x = obj.x + obj.velo.x * dt
	obj.y = obj.y + obj.velo.y * dt
end

-- Check if object is in gameplay ground
function outOfBounds(obj)
	return (
		obj.x < 0 - V.margin_rtlt or
		obj.x > gRes.w + V.margin_rtlt or
		obj.y < 0 - V.margin_top or
		obj.y > gRes.h + V.margin_bottom
		)
end

-- Check if two objects are colliding
function IsColliding(e1, e2)
	return (
		e1.x < e2.x + e2.w and
		e2.x < e1.x + e1.w and

		e1.y < e2.y + e2.h and
		e2.y < e1.y + e1.h
		)
end


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

