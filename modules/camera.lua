Camera = {}


function Camera:init()

	self.x = 0
	self.y = 0

	self.int_x = 0
	self.int_y = 0

	self.shaking = false
end

function Camera:update(dt)
	if self.shaking then
		self.x = love.math.random(-self.int_x, self.int_x)
		self.y = love.math.random(-self.int_y, self.int_y)
	else
		self.x = 0
		self.y = 0
	end

			-- shake.disp_x, shake.disp_y = shake.int_x, shake.int_y
		-- if shake.shaking then
		-- 	shake.disp_x = love.math.random(-shake.int_x, shake.int_x)
		-- 	shake.disp_y = love.math.random(-shake.int_y, shake.int_y)
		-- else
		-- 	shake.disp_x, shake.disp_y = 0, 0
		-- end
end

function Camera:shake(intensity, duration)

	self.shaking = true
	self.int_x, self.int_y = intensity, intensity
	Alarm:after(duration, Camera.stopShake)
	
end

function Camera.stopShake()
	Camera.shaking = false
end