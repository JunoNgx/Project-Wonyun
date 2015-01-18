pause = {}

function pause:enter()
	-- love.graphics.setBackgroundColor(0,0,0,120)
end

function pause:draw()
	love.graphics.setColor(c.white)
	Jutils.print('PAUSED', 0.5, 0.5, m_LarFont, true)
end

function pause:keypressed(k)
	if k == 'p' then
		Gamestate.pop()
	end
end