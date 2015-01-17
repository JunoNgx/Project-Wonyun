Input = {
	T = {
		index = nil,
		isDown = false,
		-- ox = nil,
		-- oy = nil,
		ox = 0,
		oy = 0,
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
	if Input.T.isDown then
		Input.T.recordDue = Input.T.recordDue - dt

		if Input.T.recordDue <= 0 then
			Input.T.rx = Input.T.getX()
			Input.T.ry = Input.T.getY()

			Input.T.recordDue = V.inputRecordRate
		end
	end
end

function Input:draw()
	if Input.T.isDown and G.debugMode then
		love.graphics.setColor(255,123,231, 255)
		love.graphics.circle('line', Input.T.rx, Input.T.ry, 15)
	end
end

function Input.T.getX()
	if love.system.getOS() == 'Android' then
		local id, x, y = love.touch.getTouch(1)
		return x * gRes.w
	elseif love.system.getOS() == 'Windows' then
		return M.getX()
	end
end

function Input.T.getY()
	if love.system.getOS() == 'Android' then
		local id, x, y = love.touch.getTouch(1)
		return y * gRes.h
	elseif love.system.getOS() == 'Windows' then
		return M.getY()
	end
end