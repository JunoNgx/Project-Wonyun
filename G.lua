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
	w_ReloadTime1 = 0.2,
	w_ReloadTime2 = 1.5,
	w_ReloadTime3 = 3,
	w_captureReloadTime = 10,

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
	t_velo1 = 200,
	t_velo2 = 400,
	t_velo3 = 800,
	t_velo4 = 1000,

	t_hParalRate1 = 1.0,
	t_hParalRate2 = 0.75,
	t_hParalRate3 = 0.5,
	t_hParalRate4 = 0.25,

	-- t_x1_2 = 160,
	-- t_x1_1 = 120,

	-- t_x2_2 = 120,
	-- t_x2_1 = 80,

	-- t_x3_2 = 80,
	-- t_x3_1 = 40,

	-- t_x4_2 = 40,
	-- t_x4_1 = 0,

	t_x1_2 = 200,
	t_x1_1 = 160,

	t_x2_2 = 180,
	t_x2_1 = 120,

	t_x3_2 = 140,
	t_x3_1 = 80,

	t_x4_2 = 100,
	t_x4_1 = 40,

	--UI

	ui_DistanceBar_x = 12,
	ui_DistanceBar_y_top = 24,
	ui_DistanceBar_y_bottom = 296,


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



colorTrench = {
	{ 76, 149, 136},
	{ 50, 152, 186},
	{235, 207, 120},
	{195,  77,  88},
}