-- Gameplay tuning variables

V = {
	gameplayMargin = 200,

	-- Control
	inputRecordRate = 0.05,
	inputTweenTime = 0.2,

	distanceDestination = 15000,

	playerReloadTime = 0.2,

	e_fighterFireRate = 1.5,
	e_fighterVeloY = 100,

	bullet_fDamage = 4,
	bullet_fVelo = 1000,
	bullet_fMuzzleTime = 0.02,

	bullet_eDamage = 1,
	-- bullet_eVeloX = 300,
	bullet_eVeloY = 300,
}

-- Game Settings and utilities

G = {
	version = 'pre-alpha',

	-- debugMode = true,
	debugMode = false,
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

