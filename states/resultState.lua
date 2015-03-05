result = {}

function result:enter()
	love.graphics.setBackgroundColor(20,20,20)

	row = {
		a = 0.2,
		b = 0.25,
		c = 0.31,

		d = 0.45,
		e = 0.5,
		f = 0.56,

		g = 0.7,
		h = 0.78,
		i = 0.86,

	}

	column = {
		a = 0.2,
		b = 0.5,
		c = 0.8,
	}

	self.lifetime = 0

	self.key = {
		back = '',
		again = '',
	}
end

function result:update(dt)
	self.lifetime = self.lifetime + dt

	if Input.mode == 'keyboard' then
		self.key = {
			back = '[backspace]',
			again = '[return]',
		}
	elseif Input.mode == 'gamepad' then
		self.key = {
			back = '[back]',
			again = '[start]',
		}
	elseif Input.mode == 'touch' then
		self.key = {
			back = '',
			again = '',
		}
	end
end

function result:draw()
	-- Jutils.print(string, x, y, font, relativePrint, r, scale_x, scale_y, shearing_x, shearing_y, limit, alignment)

	-- Show outcome stats
	love.graphics.setColor(c.white)
	Jutils.print('hostiles eliminated:', column.a, row.a, m_SmaFont, true)
	Jutils.print('12', column.a, row.c, m_LarFont, true)

	Jutils.print('distance travelled:', column.b, row.a, m_SmaFont, true)
	Jutils.print('125,485', column.b, row.c, m_LarFont, true)

	Jutils.print('equipments returned:', column.c, row.a, m_SmaFont, true)
	Jutils.print('4', column.c, row.c, m_LarFont, true)

	-- Show score
	Jutils.print('total score:', column.b, row.d, m_SmaFont, true)
	Jutils.print('20,000', column.b, row.f, m_LarFont, true)


	-- Show importance
	love.graphics.setColor(c.grey)
	Jutils.print('(not important)', column.a, row.b, m_SmaFont, true)
	Jutils.print('(most important)', column.b, row.b, m_SmaFont, true)
	Jutils.print('(fairly important)', column.c, row.b, m_SmaFont, true)

	Jutils.print('(for the sake of score only)', column.b, row.e, m_SmaFont, true)

	-- Buttons
	love.graphics.setColor(c.white)
	Jutils.print(self.key.back, 0.3, 0.7, m_SmaFont, true)
	Jutils.print('back', 0.3, 0.75, m_SmaFont, true)

	Jutils.print(self.key.again, 0.7, 0.7, m_SmaFont, true)
	Jutils.print('try again', 0.7, 0.75, m_SmaFont, true)

	-- Debug
	love.graphics.setFont(loader.Font(12))
    love.graphics.print(result.lifetime,
	gRes.w - love.graphics.getFont( ):getWidth(result.lifetime),
	gRes.h - love.graphics.getFont( ):getHeight(result.lifetime)
	)

end



function result:touchpressed(id, x, y)
	if self.lifetime > 1 then
		if (x > 0.2 and x < 0.4 and y > 0.7 and y < 0.8) then
			Gamestate.switch(play)
		elseif (x > 0.6 and x < 0.8 and y > 0.7 and y < 0.8) then
			Gamestate.switch(intro)
		end
	end
end

function result:gamepadreleased(j, b)
	if self.lifetime > 1 then
		if b == 'start' then
	    	Gamestate.switch(play)
	    elseif b == 'back' then
	    	Gamestate.switch(intro)
	    end
	end
end

function result:keyreleased(k)
	if self.lifetime > 1 then
		if k == 'return' then
			Gamestate.switch(play)
		elseif k == 'backspace' then
	    	Gamestate.switch(intro)
		end
	end
end













-- function result:touchpressed(id, x, y)
-- 	if self.lifetime > 1 then
-- 	-- if id == 0 then
-- 	-- 	Gamestate.switch(menu)
-- 	-- else
-- 		if id == 0 then
-- 			Gamestate.switch(play)
-- 		elseif id == 1 then
-- 			Gamestate.switch(intro)
-- 		end
-- 	end
-- end

-- function result:mousepressed(x, y, b)
-- 	if love.system.getOS() == 'Windows' then
-- 		if b == 'l' then
-- 	    	Gamestate.switch(intro)
-- 		elseif b == 'r' then
-- 			Gamestate.switch(play)
-- 		end
-- 	end
-- end

-- function result:keypressed(k)
-- 	if k == 'z' then
-- 		Gamestate.switch(intro)
-- 	end
-- end

-- function result:gamepadreleased(j, b)
-- 	if self.lifetime > 1 then
-- 		if b == 'start' then
-- 	    	Gamestate.switch(play)
-- 	    elseif b == 'b' then
-- 	    	Gamestate.switch(intro)
-- 	    end
-- 	end
-- end

-- function result:keyreleased(k)
-- 	if self.lifetime > 1 then
-- 		if k == 'return' then
-- 			Gamestate.switch(play)
-- 		elseif k == 'b' then
-- 			Gamestate.switch(intro)
-- 		end
-- 	end
-- end