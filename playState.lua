flux = require 'libs/flux'
Timer = require 'libs/hump.timer'

-- Gameplay modules
require 'modules/pool'
require 'modules/director'

-- Entities
require 'entities/player'
require 'entities/bullet_f'

play = {}

function play:enter()
	love.graphics.setBackgroundColor(c.grey)

	-- modules
	Input:init()
	Pool:init()
	Director:init()

	-- entities
	p = Player()
end

function play:update(dt)
	Timer.update(dt)
	flux.update(dt)

	-- modules
	Input:update(dt)
	Director:update(dt)

	-- entities
	p:update(dt)
end

function play:draw()
	-- modules
	Director:drawEntities()

	-- entities
	p:draw()

	love.graphics.setColor(c.white)
	love.graphics.setFont(debugFont)
	love.graphics.print(tostring(#Pool.bullet_f), 0, 0)
	love.graphics.print(tostring(#Director.alive), 0, 20)
	-- love.graphics.print(tostring(Input.T.ox), 0, 40)
	-- love.graphics.print(tostring(Input.T.ox), 0, 60)
	-- love.graphics.print(tostring(Input.T.isOn), 0, 80)
	-- love.graphics.print(tostring(M.getX()), 0, 100)
	-- love.graphics.print(tostring(M.getY()), 0, 120)
	-- love.graphics.print(tostring(M.getX() - Input.T.ox), 0, 140)
	-- love.graphics.print(tostring(M.getY() - Input.T.oy), 0, 160)
	-- love.graphics.print(tostring(Input.T.lastClick), 0, 180)
	-- love.graphics.print(tostring((love.math.random()>0.5)), 0, 200)
end

----------------------------------
----- PC Mouse Debug Control -----
----------------------------------

function play:mousepressed(x, y, b, isTouch)
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
		spawnBullet_f()
	end
end

function play:mousereleased(x, y, b)
	Input.T.isDown = false
end

-------------------
------ Utils ------
-------------------

function IsColliding(map, x, y)
	-- local layer = map.layers[1]
	-- local layer = map.layers[2]
    local cx, cy = math.ceil(x / map.tilewidth), math.ceil(y / map.tileheight)
    
	if map.layers['collision'].data[cy][cx] then
		return true
	else
		return false
	end
end

function doubleClickAction()
	-- love.graphics.setBackgroundColor(255,255,255)
end








