pause = {}

function pause:enter()
	-- love.graphics.setBackgroundColor(0,0,0,120)
	pause.lifetime = 0
end

function pause:update(dt)
	self.lifetime = self.lifetime + dt
end

function pause:draw()
	love.graphics.setColor(c.white)
	Jutils.print('PAUSED', 0.5, 0.5, m_LarFont, true)
end

function pause:touchpressed(id, x, y)
	if self.lifetime > 1 then
		if id == 1 then
			Gamestate.pop()
		end
	end
end

function pause:keypressed(k)
	if self.lifetime > 1 then
		if k == 'p' then
			Gamestate.pop()
		end
	end
end

function pause:gamepadpressed(j, b)
	if self.lifetime > 1 then
		if b == 'start' then
			Gamestate.pop()
		end
	end
end