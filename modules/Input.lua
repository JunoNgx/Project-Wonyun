Input = {
	T = {
		index = nil,
		isDown = false,
		ox = nil,
		oy = nil,
		lastClick = love.timer.getTime(),
	},
	-- R = {
	-- 	index = nil,
	-- 	isDown = false,
	-- 	ox = nil,
	-- 	oy = nil,
	-- 	lastClick = love.timer.getTime(),
	-- }
}

function Input:init()
	-- -- Input:GamepadAssign()
	-- if love.system.getOS() == 'Windows' then Input.mode = 'keyboard' end
	-- -- if love.system.getOS() == 'Windows' then Input.mode = 'gamepad' end
	-- if love.system.getOS() == 'Android' then Input.mode = 'touch' end
end

function Input:update(dt)

end

function Input:draw()

end