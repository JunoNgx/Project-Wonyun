ending = {}

function ending:enter()

end

function ending:update(dt)

end

function ending:draw()
	Jutils.print('You won', 0.5, 0.3, m_LarFont, true)
	Jutils.print('The Wonyun have been able to go home\n thanks to the effort of Wonyun 24', 0.5, 0.4, m_SmaFont, true)
end

function ending:touchpressed(id, x, y)
	if id == 1 then
		Gamestate.switch(intro)
	end
end

function ending:mousepressed(x, y, b)
	if love.system.getOS() == 'Windows' then
		if b == 'l' then
	 --    	Gamestate.switch(intro)
		-- elseif b == 'r' then
			Gamestate.switch(intro)
		end
	end
end


function ending:gamepadreleased(j, b)
	if b == 'start' then
    	Gamestate.switch(intro)
    end
end

function ending:keyreleased(k)
	if k == 'return' then
		Gamestate.switch(intro)
	end
end