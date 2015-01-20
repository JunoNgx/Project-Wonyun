-- Gameplay tuning variables

V = {
	margin_rtlt = 200,
	margin_top = 500,
	margin_bottom = 200,

	-- Control
	inputRecordRate = 0.05,
	inputTweenTime = 0.2,

	-- Gameplay
	distanceDestination = 15000,

	-- Wonyun/player
	w_ReloadTime = 0.2,

	-- Keadani
	k_defaultVeloY = 100,
	k_defaultFireRate = 1.5,
	k_rileyFireRate = 1.5,

	-- Bullets
	bf_veloY = -1000,
	be_veloY = 300,
	b_captureVelo = 1000,

	-- Stars
	s_maxNum = 30,
	s_veloY = 80,

	-- Dust
	d_fadingSpeed = 1.5
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
		w = 1280,
		h = 720
	}
else
    gRes = {
    	w = 1280
    }
    local ratioLandscape = love.graphics.getWidth()/love.graphics.getHeight()
    local ratioPortrait = love.graphics.getHeight()/love.graphics.getWidth()
	gRes.h = gRes.w / ratioLandscape

end

