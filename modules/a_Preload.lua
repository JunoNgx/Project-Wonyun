function preload()
	-- Shared
	debugFont =	love.graphics.newFont('assets/SourceCodePro-Medium.ttf',20)
	debugFont:setFilter('nearest','nearest')

	-- Menu
	TitleFont = love.graphics.newFont('assets/futura-bold-regular.ttf', 120)
	TitleFont:setFilter('nearest','nearest')
	SubtitleFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 30)
	SubtitleFont:setFilter('nearest','nearest')
	PlayButtonFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 70)
	PlayButtonFont:setFilter('nearest','nearest')

	m_LarFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 50)
	m_LarFont:setFilter('nearest','nearest')
	m_SmaFont = love.graphics.newFont('assets/futura-normal-regular.ttf', 30)
	m_SmaFont:setFilter('nearest','nearest')

	-- Play
	counterFont = love.graphics.newFont('assets/consola.ttf', 30)
	counterFont:setFilter('nearest','nearest')




	-- GFX assets
	gfx_wonyun 			= love.graphics.newImage('assets/wonyun.png')

	gfx_riley 			= love.graphics.newImage('assets/riley.png')
	gfx_augustus 		= love.graphics.newImage('assets/augustus.png')
	gfx_dulce 			= love.graphics.newImage('assets/dulce.png')
	gfx_hammerhead 		= love.graphics.newImage('assets/hammerhead.png')
	gfx_koltar 			= love.graphics.newImage('assets/koltar.png')

	gfx_meteor			= love.graphics.newImage('assets/meteor.png')

	gfx_bullet_f		= love.graphics.newImage('assets/bullet_f.png')
	gfx_bullet_e		= love.graphics.newImage('assets/bullet_e.png')

	gfx_throttle1		= love.graphics.newImage('assets/throttle1.png')
	gfx_throttle2		= love.graphics.newImage('assets/throttle2.png')

	-- decor objects
	gfx_star 			= love.graphics.newImage('assets/star.png')
	gfx_dust			= love.graphics.newImage('assets/dust.png')

	-- debug objects
	-- debugGalaxy			= love.graphics.newImage('assets/galaxy.png')
	debugFilter			= love.graphics.newImage('assets/backgroundFilter.png')
	
end