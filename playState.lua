local flux = require 'libs/flux'
local Alarm = require 'libs/Jalarm'

-- Gameplay modules
require 'modules/pool'
require 'modules/director'

-- Entities
require 'entities/player'
require 'entities/bullet_f'
require 'entities/fighter'
require 'entities/bullet_e'

play = {}

function play:enter()
	love.graphics.setBackgroundColor(c.grey)

	-- modules
	Input:init()
	Pool:init()
	Director:init()

	Alarm:reset()

	-- settings
	play.state = 'initialising'
	Alarm:after(1, function() play.state = 'inPlay' end)

	-- entities
	p = Player()
	table.insert(Director.alive, p)

	-- debug codes
	Timer.addPeriodic(1, function()
		local x = love.math.random(gRes.w)
		local y = 0

		spawnFighter(x, y)
		end)

	collided = false
end

function play:update(dt)
	Alarm:update(dt)
	Timer.update(dt)
	flux.update(dt)

	-- modules
	Input:update(dt)
	Director:update(dt)
	Director:updateCollision(dt)

	-- entities
	-- p:update(dt)

	-- event
	-- if p.exists == false then
	-- 	Alarm:after(2, function()
	-- 		Gamestate.switch(result)
	-- 	end)
	-- end
end

function play:draw()
	-- modules
	Director:drawEntities()

	-- entities
	-- p:draw()

	love.graphics.setColor(c.white)
	love.graphics.setFont(debugFont)
	love.graphics.print('Bullets in pool: '..tostring(#Pool.bullet_f), 0, 0)
	love.graphics.print('Entities in play: '..tostring(#Director.alive), 0, 20)
	-- love.graphics.print(tostring(Input.T.ox), 0, 40)
	-- love.graphics.print(tostring(Input.T.ox), 0, 60)
	love.graphics.print(tostring(play.state), 0, 80)
	-- love.graphics.print(tostring(M.getX()), 0, 100)
	-- love.graphics.print(tostring(M.getY()), 0, 120)
	love.graphics.print(tostring(p.x), 0, 140)
	love.graphics.print(tostring(p.y), 0, 160)
	love.graphics.print(tostring(p.lifetime), 0, 180)
	love.graphics.print(tostring(collided), 0, 200)
end

function play:leave()
	Timer.clear()
end

-------------------
------ Utils ------
-------------------

function IsColliding(e1, e2)
	return (
		e1.x < e2.x + e2.w and
		e2.x < e1.x + e1.w and

		e1.y < e2.y + e2.h and
		e2.y < e1.y + e1.h
		)
end

function doubleClickAction()
	-- love.graphics.setBackgroundColor(255,255,255)
end

----------------------------------
------ Mobile Touch Control ------
----------------------------------

function play:touchpressed(id, x, y)
	if play.state == 'inPlay' then
		if love.system.getOS() == 'Android' then

			-- Move the ship with single touch
			if id == 0 then
				Input.T.isDown = true
				Input.T.ox = gRes.w * x
				Input.T.oy = gRes.h * y
				p:AmendOldPos()

				-- Double click action
				if love.timer.getTime() - Input.T.lastClick < 0.3 then
					doubleClickAction()
				end

				-- Record last click for next double click
				if id == 0 then Input.T.lastClick = love.timer.getTime() end

			elseif id == 1 then

				-- Firing with multitouch
				if p.alive and p:readyToFire() then
					p:fire()
					spawnBullet_f()
				end
				
			end
		end
	end
end

function play:touchreleased(id, x, y)
	if play.state == 'inPlay' then
		if love.system.getOS() == 'Android' and id == 0 then
			Input.T.isDown = false
		end
	end
end


----------------------------------
----- PC Mouse Debug Control -----
----------------------------------

function play:mousepressed(x, y, b, isTouch)
	if play.state == 'inPlay' then
		if love.system.getOS() == 'Windows' then
			if b == 'l' then
				Input.T.isDown = true
				Input.T.ox = M.getX()
				Input.T.oy = M.getY()
				p:AmendOldPos()

				if love.timer.getTime() - Input.T.lastClick < 0.3 then
					doubleClickAction()
				end

				Input.T.lastClick = love.timer.getTime()
			elseif b == 'r' then
				if p.alive and p:readyToFire() then
					p:fire()
					spawnBullet_f()
				end
			end
		end
	end
end

function play:mousereleased(x, y, b)
	if play.state == 'inPlay' then
		if love.system.getOS() == 'Windows' and b == 'l' then
			Input.T.isDown = false
		end
	end
end




