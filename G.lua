-- Game Settings and utilities

G = {
	version = 'pre-alpha',
	debugMode = false,
	-- debugMode = true,
	hallucinativeMode = false,
	sensitivity = 100
}

-- Data saving and loading

Progress = {
	attempts = 1,
	offenseLevel = 1,
	defenseLevel = 1,
	capureUnlocked = 0,
	totalDistance = 0,

}

function LoadProgress()
	if not love.filesystem.exists("Progress") then
		love.filesystem.newFile("Progress")
	else
		Progress = Tserial.unpack(love.filesystem.read('Progress'))
	end
end

function SaveProgress()
	love.filesystem.write('Progress', Tserial.pack(Progress))
end



Settings = {
	sfx = 'on',
	music = 'on',
	sensitivity = 'medium',
}

function LoadSettings()
	if not love.filesystem.exists("Settings") then
		love.filesystem.newFile("Settings")
	else
		Settings = Tserial.unpack(love.filesystem.read('Settings'))
	end	
end

function SaveSettings()
	love.filesystem.write('Settings', Tserial.pack(Settings))
end


-- Gameplay tuning variables

V = {
	margin_rtlt = 350,
	margin_top = 500,
	margin_bottom = 250,

	-- Control
	inputRecordRate = 0.05,
	inputTweenTime = 0.2,

	-- Gameplay
	distanceDestination = 250000,

	spawnDueMin = 2,
	spawnDueMax = 5,

	-- Wonyun/player
	w_ReloadTime1 = 0.4,
	w_ReloadTime2 = 1.5,
	w_ReloadTime3 = 3,
	w_dpadVelo = 700,
	w_rotateSpd = 5,
	w_bulletVelo = 1500,
	w_captureReloadTime = 2,
	w_captureRange = 250,
	-- w_captureVelo = 1000,
	w_parts_bullet_fadeSpd = 500,
	w_parts_rSpd_ready = 500,
	w_parts_rSpd_fire = 800,

	-- Keadani
	k_defaultVelo = 100,
	k_defaultFireRate = 1.5,

	k_rileyFireRate = 1.5,

	k_augustusFireRate = 1.5,

	k_dulceFireRate = 0.8,
	k_dulceVelo = 300,

	k_hammerheadFireRate = 1.5,

	k_koltarFireRate = 0.5,


	-- Meteor
	m_defaultSize = 48,
	m_defaultVelo = 300,
	m_emitRate = 0.01,

	-- Bullets
	-- bf_veloY = -1000,

	be_defaultVelo = 300,
	-- be_veloY = 300,

	b_captureVelo = 1000,

	-- Stars
	s_maxNum = 30,
	s_veloY = 80,

	-- Dust
	d_velo = 100,
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
	f_minmaxLifetime = 3,
	f_maxmaxLifetime = 9,
	f_emitRate = 0.01,
	f_minturnSpeed = 5,
	f_maxturnSpeed = 500,
	f_minVelo = 400,
	f_maxVelo = 800,

	-- trench walls
	t_length = 800,
	t_height = 150,
	t_innerPointMod = 200,

	t_velo1 = 400,
	t_velo2 = 800,
	t_velo3 = 1600,
	t_velo4 = 2000,

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

	t_x1_2 = 400,
	t_x1_1 = 300,

	t_x2_2 = 300,
	t_x2_1 = 100,

	t_x3_2 = 200,
	t_x3_1 = 0,

	t_x4_2 = 300,
	t_x4_1 = 0,

	-- Drones
	drone_velo = 200,
	drone_dueSpawnDist = 40000,

	-- Carcasses
	c_velo = 200,

	--UI

	ui_DistanceBar_x = 34,
	ui_DistanceBar_y_top = 120,
	ui_DistanceBar_y_bottom = 680,

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



colorTrench = {
	{ 76, 149, 136},
	{ 50, 152, 186},
	{235, 207, 120},
	{195,  77,  88},
}