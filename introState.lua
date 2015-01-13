Timer = require 'libs/hump.timer'

intro = {}

function intro:enter()

	love.graphics.setBackgroundColor(20,20,20)

	imgAureo = love.graphics.newImage('assets/AureolineTetrahedron.png')
	overlay = {20, 20, 20, 255}

	Timer.add(1, function() 
			Timer.tween (1, overlay, {20,20,20,0}, 'linear')
		end)
	Timer.add(4, function() 
			Timer.tween (1, overlay, {20,20,20,255}, 'linear')
		end)
	Timer.add(6, function()
			if Gamestate.current() == intro then
				Gamestate.switch(play)
			end
		end)
end

function intro:update(dt)
	Timer.update(dt)
end

function intro:draw()
	love.graphics.setColor(c.white)
	Jutils.draw(imgAureo, gRes.w/2, gRes.h/2)

	love.graphics.setColor(overlay)
	love.graphics.rectangle('fill',0,0, gRes.w, gRes.h)

	love.graphics.setColor(255,255,255)
    love.graphics.print("Tap to skip",
    	gRes.w - love.graphics.getFont( ):getWidth("Tap to skip"),
    	gRes.h - love.graphics.getFont( ):getHeight("Tap to skip")
    	)
end

function intro:mousereleased()
    Gamestate.switch(play)
end