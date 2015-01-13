Jutils = {}

function Jutils.draw(image, x, y, radian, scale)
	local x = x or 0
	local y = y or 0

	if x == 'mid' then x = love.graphics.getWidth()/2 end
	if y == 'mid' then y = love.graphics.getHeight()/2 end

	local radian = radian or 0
	local scale = scale or 1

	love.graphics.draw(image, x, y,
		radian, scale, scale,
		image:getWidth()/2, image:getHeight()/2)
end

function Jutils.setOpa(opa)
	love.graphics.setColor(255,255,255,opa)
end

Jutils.__index = Jutils
return Jutils