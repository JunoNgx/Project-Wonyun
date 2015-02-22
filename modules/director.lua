Director = {
	-- alive = {},
}

function Director:init()
	Director.alive = {}
	Director.distanceTravelled = 0

	-- The two buttons at two corner
	Director.buttons = {
		switchWeapon = {
			x 			= 48,
			y 			= 48,
			l 			= 128,
			gfx 		= gfx_ui_weapButton[1],
			switch = function()
				Director.buttons.switchWeapon.gfx = gfx_ui_weapButton[p.currentWeapon]
			end,
		},

		pause = {
			x 			= gRes.w - 48,
			y 			= 48,
			l 			= 96,
			gfx 		= gfx_ui_pauseButton,
		},
	}

	-- Distance counter
	self.pointer = {
		x = V.ui_DistanceBar_x + 20,
		y = V.ui_DistanceBar_y_bottom,
	}
end

-- ======================= --
-- Main Gameplay Mechanics --
-- ======================= --

function Director:update(dt)
	self.distanceTravelled = self.distanceTravelled + dt * 600

	local distanceBarLength = V.ui_DistanceBar_y_bottom - V.ui_DistanceBar_y_top
	self.pointer.y = V.ui_DistanceBar_y_bottom - distanceBarLength * (self.distanceTravelled / V.distanceDestination)
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

			if entity.baseid == 'drone' then
				table.insert(Pool.drone, entity)
			end

			-- Removal codes ends here --
			table.remove(Director.alive, i)
		end
		
	end
end

function Director:updateCollision(dt)
	for i, entity in ipairs(Director.alive) do
		for i, hitEntity in ipairs(Director.alive) do
			if entity ~= hitEntity and hitEntity.alive and IsColliding(entity, hitEntity) then

				-- wonyun vs keadani, physical collision
				if entity.typeid == 'wonyun' and hitEntity.typeid == 'keadani' then

					entity:hit(1)
					hitEntity:hit(3)

				end

				-- wonyun vs meteor
				if entity.typeid == 'wonyun' and hitEntity.typeid == 'meteor' then

					entity:hit(1)
					hitEntity:hit(1)

				end

				-- wonyun vs hostile bullets
				if entity.typeid == 'wonyun' and hitEntity.typeid == 'bullet_e' then

					entity:hit(1)
					hitEntity:hit(1)

				end

				-- wonyun vs pickup
				if entity.typeid == 'wonyun' and hitEntity.typeid == 'drone' then

					hitEntity:acquired()

				end

				-- wonyun vs captured bullet
				if entity.typeid == 'wonyun' and hitEntity.typeid == 'bullet_c' then

					entity:gainAmmo(1)
					hitEntity:hit(1)

				end

----------------------


				-- keadani vs meteor
				if entity.typeid == 'keadani' and hitEntity.typeid == 'meteor' then

					entity:hit(1)
					hitEntity:hit(1)

				end

				-- keadani vs bullet_f or bullet_c
				if entity.typeid == 'keadani' and (hitEntity.typeid == 'bullet_f' or hitEntity.typeid == 'bullet_c') then

					entity:hit(1)
					hitEntity:hit(1)

				end

-----------------------

				-- meteor vs bullet_e and bullet_f and bullet_c
				if entity.typeid == 'meteor' and
					(hitEntity.typeid == 'bullet_f' or hitEntity.typeid == 'bullet_e' or hitEntity.typeid == 'bullet_c') then

					entity:hit(1)
					hitEntity:hit(1)

				end

			end
		end
	end

		-- -- Player hit by other things
		-- if entity.typeid == 'wonyun' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and hitEntity.alive and IsColliding(entity, hitEntity) then
		-- 			if hitEntity.alliance ~= 'friendly' then

		-- 				if hitEntity.objType == 'vessel' then
		-- 					-- If hit a non-friendly vessel then instantly destroy the other vessel
		-- 					entity:hit(1)
		-- 					hitEntity:hit(3)

		-- 				elseif hitEntity.objType == 'bullet' then
		-- 					-- hit by a bullet
		-- 				    entity:hit(1)
		-- 				    hitEntity:hit(1)

		-- 				elseif hitEntity.objType == 'pickup' then
		-- 					if hitEntity.pickedUp == false then
		-- 						-- Collide with a supply drone
		-- 						hitEntity:acquired()
		-- 					end
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end

		-- -- Friendly bullets hit others
		-- if entity.objType == 'bullet' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and IsColliding(entity, hitEntity) then
		-- 			if hitEntity.objType == 'vessel' and entity.alliance ~= hitEntity.alliance then

		-- 				entity:hit(1)
		-- 				hitEntity:hit(1)
		-- 			end
		-- 		end
		-- 	end
		-- end

		-- -- Meteors hitting others
		-- if entity.objType == 'vessel' and entity.alliance == 'neutral' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and IsColliding(entity, hitEntity) then
		-- 			if hitEntity.objType == 'vessel' then
		-- 				entity:hit(2)
		-- 				hitEntity:hit(2)
		-- 			end
		-- 		end
		-- 	end
		-- end

		-- Enemy vessels hit by anything non-hostile
		-- if entity.baseid == 'keadani' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and IsColliding(entity, hitEntity) then
		-- 			if hitEntity.alliance ~= 'hostile' then

		-- 				entity:hit(1)
		-- 				hitEntity:hit(1)
		-- 			end
		-- 		end
		-- 	end
		-- end

		-- Neutral vessels hit by everything not itself
		-- if entity.alliance == 'neutral' and entity.objType == 'vessel' then
		-- 	for i, hitEntity in ipairs(Director.alive) do
		-- 		if entity ~= hitEntity and IsColliding(entity, hitEntity) then

		-- 			entity:hit(1)
		-- 			hitEntity:hit(1)
					
		-- 		end
		-- 	end
		-- end


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

	-- end
end

function Director:drawEntities()
	for i = 1, #Director.alive do
		Director.alive[i]:draw()
	end
end

function Director:drawUI()
	-- buttons
	love.graphics.setColor(255,255,255)
	Jutils.draw(self.buttons.switchWeapon.gfx, self.buttons.switchWeapon.x, self.buttons.switchWeapon.y)
	if G.debugMode then
		love.graphics.setLineWidth(1)
		love.graphics.rectangle('line',
			Director.buttons.switchWeapon.x - Director.buttons.switchWeapon.l/2,
			Director.buttons.switchWeapon.y - Director.buttons.switchWeapon.l/2,
			Director.buttons.switchWeapon.l, Director.buttons.switchWeapon.l)
	end
	Jutils.draw(self.buttons.pause.gfx, self.buttons.pause.x, self.buttons.pause.y)
	-- Jutils.print(humanizeCounter(math.floor(Director.distanceTravelled)),
	-- 	0.5, 0.05, counterFont, true)

	-- Distance bar
	love.graphics.setColor(255,255,255)
	-- love.graphics.setLineWidth(1)
	-- love.graphics.line(12,24, 12,gRes.h - 64)
	love.graphics.line(
		V.ui_DistanceBar_x, V.ui_DistanceBar_y_top,
		V.ui_DistanceBar_x, V.ui_DistanceBar_y_bottom)

	-- Distance pointer
	love.graphics.setColor(100, 150, 200)
	love.graphics.polygon('fill',
		self.pointer.x - 10, self.pointer.y,
		self.pointer.x + 10, self.pointer.y - 10,
		self.pointer.x + 10, self.pointer.y + 10
		)
	-- love.graphics.rectangle('fill', self.pointer.x, self.pointer.y, 20, 20)

	-- Distance text
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(counterFont)
	love.graphics.print(humanizeCounter(math.floor(Director.distanceTravelled)),
		self.pointer.x + 20, self.pointer.y - 10, 0, 1,1,
		0,
		0
		-- counterFont:getWidth(humanizeCounter(math.floor(Director.distanceTravelled)))/2
		)

end

--------------------------------

function hitSwitchButton(x, y)
	return (
		Director.buttons.switchWeapon.x - Director.buttons.switchWeapon.l/2 <= x
		and x <= Director.buttons.switchWeapon.x + Director.buttons.switchWeapon.l/2
		and Director.buttons.switchWeapon.y - Director.buttons.switchWeapon.l/2 <= y
		and y <= Director.buttons.switchWeapon.y + Director.buttons.switchWeapon.l/2
		)
end


function hitPauseButton(x, y)
	return (
		Director.buttons.pause.x - Director.buttons.pause.l/2 <= x
		and x <= Director.buttons.pause.x + Director.buttons.pause.l/2
		and Director.buttons.pause.y - Director.buttons.pause.l/2 <= y
		and y <= Director.buttons.pause.y + Director.buttons.pause.l/2
		)
end

function hitObject(x, y, obj)
	return (
		obj.x - obj.w/2 <= x
		and x <= obj.x + obj.w/2
		and obj.y - obj.h/2 <= y
		and y <= obj.y + obj.h/2
		)
end

function wonyunBulletCapture(wonyun)
	for i, entity in ipairs(Director.alive) do
		if entity.typeid == 'bullet_e' and lume.distance(wonyun.x, wonyun.y, entity.x, entity.y) <= V.w_captureRange then
			entity:captured()
			entity:moveTo(wonyun)
		end
	end
end