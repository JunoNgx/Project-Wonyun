-- Gameplay tuning variables

V = {
	margin_rtlt = 200,
	margin_top = 500,
	margin_bottom = 200,

	-- Control
	inputRecordRate = 0.05,
	inputTweenTime = 0.2,

	-- Gameplay
	distanceDestination = 250000,

	-- Wonyun/player
	w_ReloadTime = 0.2,

	-- Keadani
	k_defaultVeloY = 100,
	k_defaultFireRate = 1.5,
	k_rileyFireRate = 1.5,

	-- Meteor
	m_defaultSize = 48,
	m_defaultVelo = 300,
	m_emitRate = 0.01,

	-- Bullets
	bf_veloY = -1000,
	be_veloY = 300,
	b_captureVelo = 1000,

	-- Stars
	s_maxNum = 30,
	s_veloY = 80,

	-- Dust
	d_fadingSpeed = 1.5,
	d_fadingSpeedMin = 1.2,
	d_fadingSpeedMax = 1.7,

	-- Light
	l_veloY = 3000,

	-- explosion
	e_lifetimeMax = 1,
	e_frameRate = 0.02,
	-- e_frameRate = 0.5,

}

-- Game Settings and utilities

G = {
	version = 'pre-alpha',

	debugMode = false,
	debugMode = true,
	sensitivity = 70
}

-- Game design resolution

if love.system.getOS() ~= 'Android' then
	gRes = {
		w = 1920,
		h = 1080
	}
else
    gRes = {
    	w = 1280
    }
    local ratioLandscape = love.graphics.getWidth()/love.graphics.getHeight()
    local ratioPortrait = love.graphics.getHeight()/love.graphics.getWidth()
	gRes.h = gRes.w / ratioLandscape

end

