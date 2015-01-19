local flux = require 'libs/flux'
local Alarm = require 'libs/Jalarm'
local Timer = require "libs/hump.timer"

-- Gameplay modules
require 'modules/pool'
require 'modules/director'
require 'modules/roadie'

-- Entities
require 'entities/star'

require 'entities/wonyun'
require 'entities/keadani'
require 'entities/bullet'

play = {}

function play:enter()

	love.graphics.setBackgroundColor(c.viridian)

	-- modules
	Input:init()
	Pool:init()
	Director:init()
	Roadie:init()

	Alarm:reset()
	Timer.clear()

	-- settings
	play.state = 'initialising'
	Alarm:after(1, function() play.state = 'inPlay' end)

	-- entities
	p = Wonyun(1, true, false)
	table.insert(Director.alive, p)

	-- debug codes
	Timer.addPeriodic(1, function()
		local x = love.math.random(gRes.w)
		local y = 0

		spawnKeadani(1, x, y)
		end)
end

function play:update(dt)
	if play.state ~= 'paused' then
		Alarm:update(dt)
		Timer.update(dt)
		flux.update(dt)

		-- modules
		Input:update(dt)
		Director:update(dt)
		Director:updateEntities(dt)
		Director:updateCollision(dt)
		Roadie:update(dt)

		-- entities
		-- p:update(dt)

		-- event
		if p.exists == false then
			Alarm:after(2, function() Gamestate.switch(result) end)
		end

		if Director.distanceTravelled >= V.distanceDestination then
			Alarm:after(2, function() Gamestate.switch(ending) end)
		end
	end
end

function play:draw()
	-- background layer
	love.graphics.setColor(255,255,255)
	love.graphics.draw(debugGalaxy)
	Roadie:draw()

	-- main gameplay layer
	Director:drawEntities()

	-- UI
	Input:draw()
	Director:drawUI()

	love.graphics.setColor(c.white)
	love.graphics.setFont(debugFont)
	love.graphics.print('Bullets in pool: '..tostring(#Pool.bullet), 0, 0)
	love.graphics.print('Keadani in play: '..tostring(#Pool.keadani), 0, 20)
	love.graphics.print('Entities in play: '..tostring(#Director.alive), 0, 40)
	-- love.graphics.print(tostring(Input.T.ox), 0, 60)
	love.graphics.print(tostring(play.state), 0, 80)
	-- love.graphics.print(tostring(M.getX()), 0, 100)
	-- love.graphics.print(tostring(M.getY()), 0, 120)
	-- love.graphics.print(tostring(p.x), 0, 140)
	-- love.graphics.print(tostring(p.y), 0, 160)
	-- love.graphics.print(tostring(p.lifetime), 0, 180)
	love.graphics.print(tostring(love.math.random(-1,1)), 0, 200)

	-- rightside
	love.graphics.print('ammo '..tostring(p.ammo), 700, 0)
	love.graphics.print('armor '..tostring(p.isArmoured), 700, 20)
	love.graphics.print('shield '..tostring(p.isShielded), 700, 40)
	love.graphics.print('reloaded '..tostring(p:readyToFire()), 700, 60)
	love.graphics.print('ammo check '..tostring(p:checkAmmo()), 700, 80)
	love.graphics.print('velo x '..tostring(p.velo.x), 700, 100)
	love.graphics.print('velo y '..tostring(p.velo.y), 700, 120)
	-- love.graphics.print(tostring(p.x), 700, 140)
	-- love.graphics.print(tostring(p.y), 700, 160)
end

function play:leave()
	-- Alarm:reset()
	-- Timer.clear()
end

------------------------------
-- Functional functions ------
------------------------------

function play:pause()
	play.state = 'paused'
	Gamestate.push(pause)
end

function play:resume()
	play.state = 'inPlay'
end

-------------------
------ Utils ------
-------------------



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
				p.tweenDue = 0
				Input.T.isDown = true
				Input.T.recordDue = 0

				-- Double click action
				if love.timer.getTime() - Input.T.lastClick < 0.3 then
					doubleClickAction() 
				end

				-- Record last click for next double click
				if id == 0 then Input.T.lastClick = love.timer.getTime() end

			elseif id == 1 then

				if p:checkVitals() then
					p:fire()
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
				Input.T.recordDue = 0

				if love.timer.getTime() - Input.T.lastClick < 0.3 then
					doubleClickAction()
				end

				if id == 0 then Input.T.lastClick = love.timer.getTime() end

			elseif b == 'r' then

				if p:checkVitals() then
					p:fire()
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

function play:keypressed(k)
	if k == 'p' then
		if play.state == 'inPlay' then
			play:pause()
		elseif play.state == 'paused' then
			play:resume()
		end
	end
end