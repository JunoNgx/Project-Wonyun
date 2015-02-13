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
	d_velo = 50,
	d_fadingSpeed = 1.5,
	d_fadingSpeedMin = 1.2,
	d_fadingSpeedMax = 1.7,

	-- Light
	l_veloY = 3000,

	-- explosion
	e_lifetimeMax = 1,
	e_frameRate = 0.02,
	-- e_frameRate = 0.5,

	--fragments
	f_minmaxLifetime = 2,
	f_maxmaxLifetime = 9,
	f_emitRate = 0.01,
	f_minturnSpeed = 5,
	f_maxturnSpeed = 500,
	f_minVelo = 200,
	f_maxVelo = 400,

	-- trench walls
	t_velo1 = 100,
	t_velo2 = 200,
	t_velo3 = 400,

}

-- Game Settings and utilities

G = {
	version = 'pre-alpha',

	debugMode = false,
	-- debugMode = true,
	sensitivity = 70
}

-- Game design resolution

if love.system.getOS() ~= 'Android' then
	gRes = {
		w = 640,
		h = 360
	}
else
    gRes = {
    	w = 640
    }
    local ratioLandscape = love.graphics.getWidth()/love.graphics.getHeight()
    local ratioPortrait = love.graphics.getHeight()/love.graphics.getWidth()
	gRes.h = gRes.w / ratioLandscape

end

