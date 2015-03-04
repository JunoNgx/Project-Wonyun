Input = {
	T = {
		index = nil,
		isDown = false,
		x = 0,
		y = 0,
		ox = 0,
		oy = 0,
		-- lastClick = love.timer.getTime(),
		recordDue = 0,
	},

	K = {
		Up = false,
		Dn = false,
		Lt = false,
		Rt = false,
	},

	P = {
		dx = 0,
		dy = 0,
	},

	mode = nil
}

function Input:init()
	-- Input:GamepadAssign()
	if love.system.getOS() == 'Windows' then
		Input.mode = 'keyboard' 
	elseif love.system.getOS() == 'Android' then
		Input.mode = 'touch'
	end
end

function Input:update(dt)

	if Input.mode == 'gamepad' and Input.gamepad == nil then
		Input.mode = 'keyboard'
	end

	if Input.mode == 'touch' then
		if Input.T.isDown then
			Input.T.recordDue = Input.T.recordDue - dt

			if Input.T.recordDue <= 0 then
				Input.T.rx = Input.T.x
				Input.T.ry = Input.T.y

				Input.T.recordDue = V.inputRecordRate
			end
		end

	-- ====================================== --

	elseif Input.mode == 'keyboard' then
		Input.K.Up = love.keyboard.isDown('up')
		Input.K.Dn = love.keyboard.isDown('down')
		Input.K.Lt = love.keyboard.isDown('left')
		Input.K.Rt = love.keyboard.isDown('right')

	-- ====================================== --

	elseif Input.mode == 'gamepad' then
		-- Movement utilising both Dpad and thumbstick
		-- Thumbstick allows adjustment of speed
		lt_thumb_x, lt_thumb_y, rt_thumb_x, rt_thumb_y, lt_trigger, rt_trigger = Input.gamepad:getAxes()

		local dpad = Input.gamepad:getHat(1)

		if dpad == 'l' then
			Input.P.dx = -1
		elseif dpad == 'r' then
			Input.P.dx =  1
		elseif lt_thumb_x <= -0.3 then
			Input.P.dx = lt_thumb_x
		elseif lt_thumb_x >= 0.3 then
			Input.P.dx = lt_thumb_x
		else
		    Input.P.dx = 0
		end

		if dpad == 'u' then
			Input.P.dy = -1
		elseif dpad == 'd' then
			Input.P.dy =  1
		elseif lt_thumb_y <= -0.3 then
			Input.P.dy = lt_thumb_y
		elseif lt_thumb_y >= 0.3 then
			Input.P.dy = lt_thumb_y
		else
			Input.P.dy = 0
		end

	end
end

function Input:draw()
	if Input.T.isDown and G.debugMode then
		love.graphics.setColor(255,123,231, 255)
		love.graphics.circle('line', Input.T.rx, Input.T.ry, 15)

		love.graphics.setColor(120,120,255, 255)
		love.graphics.circle('line', Input.T.x, Input.T.y, 15)
	end
end

-- function Input.T.getX()
-- 	local id, x, y = love.touch.getTouch(1)
-- 	return x * gRes.w
-- end

-- function Input.T.getY()
-- 	if love.system.getOS() == 'Android' then
-- 	local id, x, y = love.touch.getTouch(1)
-- 	return y * gRes.h
-- 	elseif love.system.getOS() == 'Windows' then
-- 		return M.getY()
-- 	end
-- end

function Input:GamepadAssign()
	if love.joystick.getJoysticks() ~= nil then
        Input.gamepad = love.joystick.getJoysticks()[1]
   	end
end

function Input.T:reset(x, y)
	self.x = x * gRes.w
	self.y = y * gRes.h
	self.rx = x * gRes.w
	self.ry = y * gRes.h
	self.recordDue = 0
end