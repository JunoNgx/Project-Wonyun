-- Gameplay tuning variables

V = {

}

-- Game Settings and utilities

G = {
	debugMode = true,
	sensitivity = 1.2
}

-- Game design resolution

if love.system.getOS() ~= 'Android' then
	gRes = {
		w = 1600,
		h = 900
	}
else
    gRes = {
    	w = 1600
    }
    local ratioLandscape = love.graphics.getWidth()/love.graphics.getHeight()
    local ratioPortrait = love.graphics.getHeight()/love.graphics.getWidth()
	gRes.h = gRes.w / ratioLandscape

end

