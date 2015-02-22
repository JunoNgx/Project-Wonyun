function preload()
	-- Shared
	debugFont =	love.graphics.newFont('assets/SourceCodePro-Medium.ttf',10)
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
	counterFont = love.graphics.newFont('assets/consola.ttf', 15)
	counterFont:setFilter('nearest','nearest')




	-- GFX assets
	gfx_wonyun 			= love.graphics.newImage('assets/wonyun.png')
	gfx_wonyun_armor 	= love.graphics.newImage('assets/wonyun_armor.png')
	gfx_wonyun_barrier 	= love.graphics.newImage('assets/wonyun_barrier.png')
	gfx_parts_arrow 	= love.graphics.newImage('assets/wonyun_parts_arrow.png')

	gfx_riley 			= love.graphics.newImage('assets/riley.png')
	gfx_augustus 		= love.graphics.newImage('assets/augustus.png')
	gfx_dulce 			= love.graphics.newImage('assets/dulce.png')
	gfx_hammerhead 		= love.graphics.newImage('assets/hammerhead.png')
	gfx_koltar 			= love.graphics.newImage('assets/koltar.png')

	gfx_meteor			= love.graphics.newImage('assets/meteor.png')

	gfx_bullet_f		= love.graphics.newImage('assets/bullet_f.png')
	gfx_bullet_e		= love.graphics.newImage('assets/bullet_e.png')

	gfx_drone_fuselage	= love.graphics.newImage('assets/drone_fuselage.png')
	gfx_drone_symbol 	= {
		love.graphics.newImage('assets/drone_1.png'),
		love.graphics.newImage('assets/drone_2.png'),
		love.graphics.newImage('assets/drone_3.png'),
	}

	gfx_throttle1		= love.graphics.newImage('assets/throttle1.png')
	gfx_throttle2		= love.graphics.newImage('assets/throttle2.png')

	-- decor objects
	gfx_star 			= love.graphics.newImage('assets/star.png')
	gfx_dust			= love.graphics.newImage('assets/dust.png')
	gfx_light			= love.graphics.newImage('assets/light.png')
	gfx_fragment		= love.graphics.newImage('assets/fragment.png')

	gfx_explosion		= {
		love.graphics.newImage('assets/explosion_1.png'),
		love.graphics.newImage('assets/explosion_2.png'),
		love.graphics.newImage('assets/explosion_3.png'),
		love.graphics.newImage('assets/explosion_4.png'),
		love.graphics.newImage('assets/explosion_5.png'),
		love.graphics.newImage('assets/explosion_6.png'),
		love.graphics.newImage('assets/explosion_7.png'),
		love.graphics.newImage('assets/explosion_8.png'),
		love.graphics.newImage('assets/explosion_9.png'),
	}

	-- UI assets
	gfx_ui_weapButton = {
		love.graphics.newImage('assets/weaponButton_1.png'),
		love.graphics.newImage('assets/weaponButton_2.png'),
		love.graphics.newImage('assets/weaponButton_3.png'),
	}
	gfx_ui_pauseButton = love.graphics.newImage('assets/pauseButton.png')

	-- debug objects
	-- debugGalaxy			= love.graphics.newImage('assets/galaxy.png')
	debugFilter			= love.graphics.newImage('assets/backgroundFilter.png')
	
end