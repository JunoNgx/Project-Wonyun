Director = {
	-- alive = {},
}

function Director:init()
	Director.alive = {}
	Director.distanceTravelled = 0

	Director.buttons = {
		switchWeapon = {
			x 			= 32,
			y 			= gRes.h - 32,
			l 			= 32,
			gfx 		= gfx_ui_weapButton[1],
			switch = function()
				Director.buttons.switchWeapon.gfx = gfx_ui_weapButton[p.currentWeapon]
			end,
		},

		pause = {
			x 			= gRes.w - 32,
			y 			= 32,
			l 			= 32,
			gfx 		= gfx_ui_pauseButton,
		},

	}
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
	Jutils.draw(self.buttons.switchWeapon.gfx, self.buttons.switchWeapon.x, self.buttons.switchWeapon.y)
	Jutils.draw(self.buttons.pause.gfx, self.buttons.pause.x, self.buttons.pause.y)
	-- Jutils.print(humanizeCounter(math.floor(Director.distanceTravelled)),
	-- 	0.5, 0.05, counterFont, true)
end

--------------------------------

function hitSwitchButton(x, y)
	return (
		Director.buttons.switchWeapon.x - Director.buttons.switchWeapon.l/2 <= x
		and x < Director.buttons.switchWeapon.x + Director.buttons.switchWeapon.l/2
		and Director.buttons.switchWeapon.y - Director.buttons.switchWeapon.l/2 <= y
		and y < Director.buttons.switchWeapon.y + Director.buttons.switchWeapon.l/2
		)
end


function hitPauseButton(x, y)
	return (
		Director.buttons.pause.x - Director.buttons.pause.l/2 <= x
		and x < Director.buttons.pause.x + Director.buttons.pause.l/2
		and Director.buttons.pause.y - Director.buttons.pause.l/2 <= y
		and y < Director.buttons.pause.y + Director.buttons.pause.l/2
		)
end