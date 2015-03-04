menu = {}

function menu:enter()
	love.graphics.setBackgroundColor(40,40,40)

	self.lifetime = 0
	self.remainingLives = 24 - Progress.attempts + 1

	self.leftRowCol = {
		{255, 255, 255},
		{100, 100, 100},
		{100, 100, 100},

		{255, 255, 255},

		{100, 100, 100},
	}

	self.key = {
		play = '',
		sfx = '',
		music = '',
		sensitivity = '',
	}

	LoadSettings()
end

function menu:update(dt)
	menu.lifetime = menu.lifetime + dt

	if Input.mode == 'keyboard' then
		self.key = {
			play = '[return]',
			sfx = '[S]',
			music = '[M]',
			sensitivity = '[V]',
		}
	elseif Input.mode == 'gamepad' then
		self.key = {
			play = '[start]',
			sfx = '[Y]',
			music = '[B]',
			sensitivity = '[A]',
		}
	elseif Input.mode == 'touch' then
		self.key = {
			play = '',
			sfx = '',
			music = '',
			sensitivity = '',
		}
	end
end

function menu:draw()
	-- Show version
	love.graphics.setColor(c.white)
	love.graphics.setFont(loader.Font(14))
	love.graphics.print('v'..G.version, gRes.w - loader.Font(14):getWidth('v'..G.version))

	-- Draw remaining lives
	local fullRow = math.floor(self.remainingLives / 6)
	local lastRow = self.remainingLives % 6

	local size = 24
	local margin_x = 0
	local margin_y = 0
	local dist = 36

	for rowID = 1, fullRow do
		for colID = 1, 6 do
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.rectangle('fill', margin_x + colID * dist, margin_y + rowID * dist, size, size)
		end
	end

	-- last row
	for colID = 1, lastRow do
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle('fill', margin_x + colID * dist, margin_y + (fullRow + 1) * dist, size, size)			
	end


	love.graphics.setColor(c.white)
	-- Jutils.print(string, x, y, font, relativePrint, alignment, r, scale_x, scale_y, shearing_x, shearing_y, limit)
	Jutils.print('WONYUN', 0.5, 0.15, TitleFont, true)
	Jutils.print('veni, vidi, in volo domum redire', 0.5, 0.25, SubtitleFont, true)

	-- Show progress
	Jutils.print('wonyun fallen:', 0.15, 0.3, m_SmaFont, true)
	Jutils.print('40', 0.15, 0.35, m_LarFont, true)

	Jutils.print('farthest attempt:', 0.15, 0.45, m_SmaFont, true)
	Jutils.print('241,556', 0.15, 0.5, m_LarFont, true)

	Jutils.print('weapon grade:', 0.15, 0.60, m_SmaFont, true)
	Jutils.print('3', 0.15, 0.65, m_LarFont, true)

	Jutils.print('extra ammunition:', 0.15, 0.75, m_SmaFont, true)
	Jutils.print('45', 0.15, 0.80, m_LarFont, true)

	love.graphics.setColor(self.leftRowCol[1])
	Jutils.print('lotherian armour', 0.85, 0.3, m_SmaFont, true)
	love.graphics.setColor(self.leftRowCol[2])
	Jutils.print('reinforced plating', 0.85, 0.35, m_SmaFont, true)
	love.graphics.setColor(self.leftRowCol[3])
	Jutils.print('energy shield', 0.85, 0.4, m_SmaFont, true)

	love.graphics.setColor(self.leftRowCol[4])
	Jutils.print('threat scanner', 0.85, 0.6, m_SmaFont, true)
	love.graphics.setColor(self.leftRowCol[5])
	Jutils.print('bullet capture module', 0.85, 0.8, m_SmaFont, true)
	love.graphics.setColor(c.white)

	-- Play button
	Jutils.print(self.key.play, 0.5, 0.44, m_SmaFont, true)
	Jutils.print('MAKE THE RUN', 0.5, 0.5, PlayButtonFont, true)

	-- Settings
	Jutils.print(self.key.sfx, 0.5, 0.60, m_SmaFont, true)
	Jutils.print('sound: '..Settings.sfx, 0.5, 0.65, m_SmaFont, true)
	Jutils.print(self.key.music, 0.5, 0.70, m_SmaFont, true)
	Jutils.print('music: '..Settings.music, 0.5, 0.75, m_SmaFont, true)

	if love.system.getOS() == 'Android' then
		Jutils.print(self.key.sensitivity, 0.5, 0.80, m_SmaFont, true)
		Jutils.print('sensitivity: '..Settings.sensitivity, 0.5, 0.85, m_SmaFont, true)
	end

	-- Copyright
	Jutils.print('2015 Aureoline Tetrahedron', 0.5, 0.95, SubtitleFont, true)

	-- Debug
	-- love.graphics.setFont(loader.Font(12))
	--     love.graphics.print(menu.lifetime,
 --    	gRes.w - love.graphics.getFont( ):getWidth(menu.lifetime),
 --    	gRes.h - love.graphics.getFont( ):getHeight(menu.lifetime)
 --    	)
	love.graphics.print(love.system.getOS())

	-- love.graphics.setColor(255,0,0,255)
	-- local wi = love.graphics.getWidth()
	-- local hi = love.graphics.getHeight()
	-- love.graphics.rectangle('line', wi * 0.3, hi * 0.45, wi * 0.4, hi * 0.1)
	-- love.graphics.rectangle('line', wi * 0.3, hi * 0.6, wi * 0.4, hi * 0.1)
	-- love.graphics.rectangle('line', wi * 0.3, hi * 0.7, wi * 0.4, hi * 0.1)
end

function menu:touchpressed(id, x, y)
	-- if id == 1 then
	-- 	Gamestate.switch(play)
	-- end
	if (x > 0.3 and x < 0.7 and y > 0.45 and y < 0.55) then
		Gamestate.switch(play)
	elseif (x > 0.3 and x < 0.7 and y > 0.6 and y < 0.7) then
		menu:switchSFX()
	elseif (x > 0.3 and x < 0.7 and y > 0.7 and y < 0.8) then
		menu:switchMusic()	
	elseif (x > 0.3 and x < 0.7 and y > 0.8 and y < 0.9) then
		menu:switchSensitivity()
	end
end

-- function menu:mousepressed(x, y, b)
-- 	if b == 'r' then
--     	Gamestate.switch(play)
-- 	end
-- end

function menu:gamepadreleased(j, b)
	if b == 'start' then
    	Gamestate.switch(play)
    elseif b == 'y' then
    	menu:switchSFX()
    elseif b == 'b' then
    	menu:switchMusic()
    end
end

function menu:keyreleased(k)
	if k == 'return' then
		Gamestate.switch(play)
	elseif k == 's' then
    	menu:switchSFX()
    elseif k == 'm' then
    	menu:switchMusic()
	end
end

function menu:switchSFX()
	if Settings.sfx == 'on' then
		Settings.sfx = 'off'
	else
		Settings.sfx = 'on'
	end
	SaveSettings()
end

function menu:switchMusic()
    if Settings.music == 'on' then
		Settings.music = 'off'
	else
		Settings.music = 'on'
	end
	SaveSettings()
end

function menu:switchSensitivity()
	if Settings.sensitivity == 'low' then
		Settings.sensitivity = 'medium'
	elseif Settings.sensitivity == 'medium' then
		Settings.sensitivity = 'high'
	elseif Settings.sensitivity == 'high' then
		Settings.sensitivity = 'low'
	end
	SaveSettings()
end