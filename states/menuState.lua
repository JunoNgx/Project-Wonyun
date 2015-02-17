menu = {}

function menu:enter()
	love.graphics.setBackgroundColor(20,20,20)

	menu.lifetime = 0
end

function menu:update(dt)
	menu.lifetime = menu.lifetime + dt
end

function menu:draw()
	-- Show version
	love.graphics.setColor(c.white)
	love.graphics.setFont(loader.Font(14))
	love.graphics.print('v'..G.version)


	love.graphics.setColor(c.white)
	-- Jutils.print(string, x, y, font, relativePrint, r, scale_x, scale_y, shearing_x, shearing_y, limit, alignment)
	Jutils.print('WONYUN', 0.5, 0.2, TitleFont, true)
	Jutils.print('veni, vidi, in volo domum redire', 0.5, 0.3, SubtitleFont, true)

	-- Show progress
	Jutils.print('wonyun fallen:', 0.2, 0.4, m_SmaFont, true)
	Jutils.print('40', 0.2, 0.45, m_LarFont, true)

	Jutils.print('farthest attempt:', 0.8, 0.4, m_SmaFont, true)
	Jutils.print('170,304', 0.8, 0.45, m_LarFont, true)

	-- Play button
	Jutils.print('tap with two fingers to', 0.5, 0.54, m_SmaFont, true)
	Jutils.print('MAKE THE RUN', 0.5, 0.6, PlayButtonFont, true)

	-- Settings
	Jutils.print('sensitivity: '..'medium', 0.5, 0.85, m_SmaFont, true)

	-- Copyright
	Jutils.print('2015 Aureoline Tetrahedron', 0.5, 0.95, SubtitleFont, true)

	-- Debug
	love.graphics.setFont(loader.Font(12))
	    love.graphics.print(menu.lifetime,
    	gRes.w - love.graphics.getFont( ):getWidth(menu.lifetime),
    	gRes.h - love.graphics.getFont( ):getHeight(menu.lifetime)
    	)
end

function menu:touchpressed(id, x, y)
	if id == 1 then
		Gamestate.switch(play)
	end
end

function menu:mousepressed(x, y, b)
	if b == 'r' then
    	Gamestate.switch(play)
	end
end

function menu:gamepadreleased(j, b)
	if b == 'start' then
    	Gamestate.switch(menu)
    end
end

function menu:keyreleased(k)
	if k == 'return' then
		Gamestate.switch(menu)
	end
end