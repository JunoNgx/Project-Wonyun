Director = {
	-- alive = {},
}

function Director:init()
	Director.alive = {}
	Director.distanceTravelled = 0
end

-- ======================= --
-- Main Gameplay Mechanics --
-- ======================= --

function Director:update(dt)
	Director.distanceTravelled = Director.distanceTravelled + dt * 420
end


function Director:updateEntities(dt)
	for i, entity in ipairs(Director.alive) do
		entity:update(dt)

		if not entity.exists then
			-- Alive entity removal codes here --

			if entity.baseid == 'keadani' then
				table.insert(Pool.keadani, entity)
			end

			if entity.baseid == 'meteor' then
				table.insert(Pool.meteor, entity)
			end

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
		if entity.typeid == 'wonyun' then
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

		-- Enemy vessel hit by anything non-hostile
		if entity.baseid == 'keadani' then
			for i, hitEntity in ipairs(Director.alive) do
				if entity ~= hitEntity and IsColliding(entity, hitEntity) then
					if hitEntity.alliance ~= 'hostile' then

						entity:hit()
						hitEntity:hit()
					end
				end
			end
		end

		-- Neutral vessels hit by everything not itself
		if entity.alliance == 'neutral' and entity.objType == 'vessel' then
			for i, hitEntity in ipairs(Director.alive) do
				if entity ~= hitEntity and IsColliding(entity, hitEntity) then

					entity:hit()
					hitEntity:hit()
					
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