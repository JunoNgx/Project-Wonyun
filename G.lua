-- Gameplay tuning variables

V = {
	gameplayMargin = 200,

	distanceDestination = 7000,

	playerReloadTime = 0.2,

	e_fighterFireRate = 1.5,
	e_fighterVelo = 100,

	bullet_fDamage = 4,
	bullet_fVelo = 1000,
	bullet_fMuzzleTime = 0.02,

	bullet_eDamage = 1,
	bullet_eVelo = 300,
}

-- Game Settings and utilities

G = {
	version = 'pre-alpha',

	-- debugMode = true,
	debugMode = true,
	sensitivity = 1.2
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

