clear = {}

function clear:enter()
	-- love.graphics.setBackgroundColor(0,0,0,120)
	self.lifetime = 0

	self.key = {
		back = '',
		confirm = '',
	}
end

function clear:update(dt)
	self.lifetime = self.lifetime + dt

	if Input.mode == 'keyboard' then
		self.key = {
			back = '[backspace]',
			confirm = '[delete]',
		}
	elseif Input.mode == 'gamepad' then
		self.key = {
			back = '[back]',
			confirm = '[start]',
		}
	elseif Input.mode == 'touch' then
		self.key = {
			back = '',
			confirm = '',
		}
	end
end

function clear:draw()
	love.graphics.setColor(c.white)
	Jutils.print('are you sure you want to clear all progress?', 0.5, 0.3, m_SmaFont, true)
	Jutils.print('this cannot be undone', 0.5, 0.35, m_SmaFont, true)

	Jutils.print(self.key.back, 0.3, 0.6, m_SmaFont, true)
	Jutils.print('back', 0.3, 0.65, m_SmaFont, true)

	Jutils.print(self.key.confirm, 0.7, 0.6, m_SmaFont, true)
	Jutils.print('confirm', 0.7, 0.65, m_SmaFont, true)

end


function clear:touchpressed(id, x, y)
	if (x > 0.2 and x < 0.4 and y > 0.6 and y < 0.7) then
		Gamestate.pop()
	elseif (x > 0.6 and x < 0.8 and y > 0.6 and y < 0.7) then
		clearProgress()
	end
end

function clear:gamepadreleased(j, b)
	if b == 'start' then
    	clearProgress()
    elseif b == 'back' then
    	Gamestate.pop()
    end
end

function clear:keyreleased(k)
	if k == 'delete' then
		clearProgress()
	elseif k == 'backspace' then
    	Gamestate.pop()
	end
end

function clearProgress()

end