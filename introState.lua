local flux = require 'libs/flux'
-- local Timer = require "libs/hump.timer"


intro = {}

function intro:enter()
	love.graphics.setBackgroundColor(20,20,20)

	local Alarm = require 'libs/Jalarm'
	Alarm:reset()

	imgAureo = love.graphics.newImage('assets/AureolineTetrahedron.png')
	overlay = {20, 20, 20, 255}

	fadeIn = function()
		flux.to(overlay, 1, {20,20,20,0}):ease('linear'):delay(1):oncomplete(fadeOut)
	end

	fadeOut = function()
		flux.to(overlay, 1, {20,20,20,255}):delay(2):ease('linear'):oncomplete(switchToMenuIn1Sec)
	end

	switchToMenuIn1Sec = function()
		Alarm:after(1, function() if Gamestate.current() == intro then Gamestate.switch(menu) end end)
	end

	fadeIn()

end

function intro:update(dt)
	-- Timer.update(dt)
	Alarm:update(dt)
	flux.update(dt)
end

function intro:draw()
	love.graphics.setColor(c.white)
	Jutils.draw(imgAureo, gRes.w/2, gRes.h/2)

	love.graphics.setColor(overlay)
	love.graphics.rectangle('fill',0,0, gRes.w, gRes.h)

	love.graphics.setColor(255,255,255)
	love.graphics.setFont(loader.Font(12))
    love.graphics.print("Tap to skip",
    	gRes.w - love.graphics.getFont( ):getWidth("Tap to skip"),
    	gRes.h - love.graphics.getFont( ):getHeight("Tap to skip")
    	)
end

function intro:leave()
	-- Timer.clear()
	Alarm:reset()
end

function intro:mousereleased()
    Gamestate.switch(menu)
end