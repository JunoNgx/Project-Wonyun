local flux = require 'libs/flux'
local Alarm = require 'libs/Jalarm'
local Timer = require "libs/hump.timer"

-- Gameplay modules
require 'modules/pool'
require 'modules/director'
require 'modules/roadie'
require 'modules/assistant'
require 'modules/camera'

-- Entities
require 'entities/star'
require 'entities/light'

require 'entities/wonyun'
require 'entities/keadani'
require 'entities/bullet'
require 'entities/meteor'
require 'entities/drone'

require 'entities/dust'
require 'entities/explosion'
require 'entities/fragment'
require 'entities/trench'
require 'entities/carcass'

play = {}

function play:enter()
	if not G.hallucinativeMode then
		love.graphics.setBackgroundColor(40,40,50,20)
	else
		love.graphics.setBackgroundColor(240,240,240,20)
	end
	love.graphics.setBackgroundColor(40,40,40,20)
	-- love.graphics.setBackgroundColor(240,240,240,255)

	-- modules
	Input:init()
	Pool:init()
	Director:init()
	Roadie:init()
	Assistant:init()
	Camera:init()

	Alarm:reset()
	Timer.clear()

	-- settings
	play.state = 'initialising'
	Alarm:after(1, function() play.state = 'inPlay' end)

	-- entities
	p = Wonyun(50, 3, 3, true)
	table.insert(Director.alive, p)

	-- debug codes

	-- enemy spawn
	Timer.addPeriodic(1, function()
		local x = love.math.random(gRes.w)
		local y = 0
		local r = love.math.random(8,23)/10

		-- spawnKeadani(love.math.random(1,5), x, y, r)
		spawnKeadani(3, x, y, r)
		end)

	-- Sky filter
	filter = {opacity = 255}
	Timer.addPeriodic(2, function()
		flux.to(filter, 2, {opacity = love.math.random(50,250)})
		end)

	-- Meteor
	Timer.addPeriodic(1, function()
		local x = love.math.random(gRes.w)
		local y = 0 - 300
		local r = love.math.random(8,23)/10
		-- local r = math.pi/2

		spawnMeteor(x, y, r)
		end)

	-- Spawn Light
	Timer.addPeriodic(2.5, function()
		spawnLight()
		end)

	-- Trench
	Timer.addPeriodic(0.3, function()
		spawnTrench('l', 4)
		end)
	Timer.addPeriodic(0.5, function()
		spawnTrench('l', 3)
		end)
	Timer.addPeriodic(0.7, function()
		spawnTrench('l', 2)
		end)
	Timer.addPeriodic(0.9, function()
		spawnTrench('l', 1)
		end)

	Timer.addPeriodic(0.3, function() -- 160/400 = 0.4 ~ 0.35
		spawnTrench('r', 4)
		end)
	Timer.addPeriodic(0.5, function() -- 160/400 = 0.4 ~ 0.35
		spawnTrench('r', 3)
		end)
	Timer.addPeriodic(0.7, function()
		spawnTrench('r', 2)
		end)
	Timer.addPeriodic(0.9, function()
		spawnTrench('r', 1)
		end)

	-- Drone
	Timer.addPeriodic(5, function()
		spawnDrone(
			love.math.random(gRes.w),
			-- 600,
			0,
			love.math.random(8,23)/10,
			love.math.random(1,3))
			-- 1)
		end)

	-- _dr = Drone()
	-- _dr:spawn( 600, 0, math.pi/2, )

	-- p.velo.y = -300

	-- d1_x, d1_y = 0, 0

end

function play:update(dt)
	if Gamestate.current() == play and play.state ~= 'paused' then
		Alarm:update(dt)
		Timer.update(dt)
		flux.update(dt)

		-- modules
		Input:update(dt)
		Director:update(dt)
		Director:updateEntities(dt)
		Director:updateCollision(dt)
		Roadie:update(dt)
		Assistant:update(dt)

		-- shaking
		Camera:update(dt)

		-- entities
		-- p:update(dt)
		if love.keyboard.isDown('d') then
			spawnDust(M.getX(), M.getY(), 0, 20)
		end

		if love.keyboard.isDown('m') then
			spawnMeteor(M.getX(), M.getY(), math.pi/2)
		end

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
	love.graphics.setColor(255,255,255, filter.opacity)

	if screenScale.x > 1 then
		love.graphics.draw(debugFilter, 0, 0, 0, 
		screenScale.x, screenScale.y 
		)
	else
		love.graphics.draw(debugFilter, 0, 0, 0, 
		1/screenScale.x, 1/screenScale.y 
		)
	end

	love.graphics.push()
		Camera:point()
		-- Jutils.draw(debugFilter, gRes.w/2, gRes.h/2, 0, love.graphics.getWidth()/debugFilter:getWidth(), love.graphics.getHeight()/debugFilter:getHeight())
		Roadie:draw()

		-- main gameplay layer
		Director:drawEntities()

		-- top decor layers
		Assistant:draw()

	love.graphics.pop()

	-- UI
	Input:draw()
	Director:drawUI()

	love.graphics.setColor(c.white)
	love.graphics.setFont(debugFont)
	love.graphics.print(love.timer.getFPS(), 0, 0)
	-- love.graphics.print(tostring(p.velo.x), 0, 20)
	-- love.graphics.print(tostring(p.velo.y), 0, 40)
	-- love.graphics.print(tostring(Input.mode.dx), 0, 60)
	love.graphics.print('Keadani '..tostring(#Pool.keadani), 0, 80)
	-- love.graphics.print('Dust in play : '..tostring(#Assistant.t1), 0, 100)
	-- love.graphics.print('trench4 : '..tostring(#Roadie.t4), 0, 120)
	-- love.graphics.print(tostring(Input.T.isDown), 0, 140)
	-- love.graphics.print(tostring(Input.T.x), 0, 160)
	-- love.graphics.print(tostring(Input.T.y), 0, 180)
	-- love.graphics.print(tostring(Input.T.rx), 0, 200)

	-- rightside
	love.graphics.print('In play '..tostring(#Director.alive), 400, 0)
	-- love.graphics.print('armor '..tostring(p.isArmoured), 700, 20)
	-- love.graphics.print('shield '..tostring(p.isShielded), 700, 40)
	-- love.graphics.print('reloaded '..tostring(p:readyToFire()), 700, 60)
	-- love.graphics.print('ammo check '..tostring(p:checkAmmo()), 700, 80)
	-- love.graphics.print('velo x '..tostring(p.velo.x), 700, 100)
	-- love.graphics.print(love.graphics.getWidth(), 400, 120)
	-- love.graphics.print(M.getX(), 700, 140)
	-- love.graphics.print(tostring(lume.distance(p.x, p.y, d1_x, d1_y)), 400, 160)s

	-- love.graphics.circle('line', d1_x, d1_y, 25)
	-- love.graphics.setColor(255,0,0)
	-- love.graphics.circle('line', p.x + Camera.x, p.y + Camera.y, 25)
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


----------------------------
----- Control schemes ------
----------------------------

function play:touchpressed(id, x, y)
	-- Interface functions
	if hitSwitchButton(gRes.w * x, gRes.h * y) then
		p:switchWeapon()
	elseif hitPauseButton(gRes.w * x, gRes.h * y) then
		Gamestate.push(pause)
	else
		-- Move the ship with single touch
		if id == 0 then
			Input.T.isDown = true
			Input.T:reset(x,y)

		-- Fire current weapon
		elseif id == 1 and p:checkVitals() then
			-- local tid, tx, ty = love.touch.getTouch(2)

			if hitPlayer(gRes.w * x, gRes.h * y) then
				p:captureBullet()
			else
				p:fire()
			end

			-- d1_x = gRes.w * tx
			-- d1_y = gRes.h * ty
		end
	end
end

function play:touchmoved(id, x, y)
	if id == 0 then
		Input.T.x = x * gRes.w
		Input.T.y = y * gRes.h
	end
end

function play:touchreleased(id, x, y)
	if id == 0 then
		Input.T.isDown = false
	end
end

function play:gamepadpressed(j, b)
	if p:checkVitals() then
		if b == 'a' or b == 'x' or b == 'rightshoulder' then
			p:fire()
		elseif b == 'b' then
			p:switchWeapon()
		elseif b == 'y' or b == 'leftshoulder' then
			p:captureBullet()
		end
	end

	if b == 'start' then
		if play.state == 'inPlay' then
			play:pause()
		elseif play.state == 'paused' then
			play:resume()
		end
	end

end

function play:keypressed(k)
	if p:checkVitals() then
		if k == 'c' or k == ' ' then
			p:fire()
		elseif k == 'x' or k == 'lalt' then
			p:switchWeapon()
		elseif k == 'v' or k == 'lctrl' then
			p:captureBullet()
		end
	end

	if k == 'p' then
		if play.state == 'inPlay' then
			play:pause()
		elseif play.state == 'paused' then
			play:resume()
		end
	end

end















----------------------------------
------ Mobile Touch Control ------
----------------------------------

-- function play:touchpressed(id, x, y)
-- 	if play.state == 'inPlay' then
-- 		if love.system.getOS() == 'Android' then

-- 			if hitSwitchButton(gRes.w * x, gRes.h * y) then
-- 					p:switchWeapon()
-- 				elseif hitPauseButton(gRes.w * x, gRes.h * y) then
-- 					Gamestate.push(pause)
-- 				else
-- 			-- Move the ship with single touch
-- 				if id == 0 then
		
-- 						p.tweenDue = 0
-- 						Input.T.isDown = true
-- 						Input.T.recordDue = 0

-- 						-- -- Double click action
-- 						-- if love.timer.getTime() - Input.T.lastClick < 0.3 then
-- 						-- 	doubleClickAction() 
-- 						-- end

-- 					-- -- Record last click for next double click
-- 					-- if id == 0 then Input.T.lastClick = love.timer.getTime() end
-- 				elseif id == 1 then

-- 					if p:checkVitals() then
-- 						p:fire()
-- 					end

-- 				end
-- 			end
-- 		end
-- 	end
-- end

-- function play:touchreleased(id, x, y)
-- 	if play.state == 'inPlay' then
-- 		if love.system.getOS() == 'Android' and id == 0 then
-- 			Input.T.isDown = false
-- 		end
-- 	end
-- end


----------------------------------
----- PC Mouse Debug Control -----
----------------------------------

-- function play:mousepressed(x, y, b, isTouch)
-- 	if play.state == 'inPlay' then
-- 		if love.system.getOS() == 'Windows' then
-- 			if b == 'l' then
-- 				Input.T.isDown = true
-- 				Input.T.recordDue = 0

-- 				if love.timer.getTime() - Input.T.lastClick < 0.3 then
-- 					doubleClickAction()
-- 				end

-- 				if id == 0 then Input.T.lastClick = love.timer.getTime() end

-- 			elseif b == 'r' then

-- 				if p:checkVitals() then
-- 					p:fire()
-- 				end

-- 			end
-- 		end
-- 	end
-- end

-- function play:mousereleased(x, y, b)
-- 	if play.state == 'inPlay' then
-- 		if love.system.getOS() == 'Windows' and b == 'l' then
-- 			Input.T.isDown = false
-- 		end

-- 	end
-- end