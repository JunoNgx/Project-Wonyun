function preload()
	-- Shared
	debugFont =	love.graphics.newFont('assets/SourceCodePro-Medium.ttf',20)
	-- debugFont:setFilter('nearest','nearest', 0)

	-- Menu
	TitleFont = love.graphics.newFont('assets/futura-bold-regular.ttf', 120)
	SubtitleFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 30)
	PlayButtonFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 70)
	-- TitleFont:setFilter('nearest','nearest', 0)
	m_LarFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 50)
	-- m_LarFont:setFilter('nearest','nearest')
	m_SmaFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 30)
	-- m_SmaFont:setFilter('nearest','nearest')

	-- Play
	counterFont = love.graphics.newFont('assets/consola.ttf', 30)
	
end