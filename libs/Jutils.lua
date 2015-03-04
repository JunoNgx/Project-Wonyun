Jutils = {}

function Jutils.draw(image, x, y, radian, scale_x, scale_y)
	local x = x or 0
	local y = y or 0

	if x == 'mid' then x = love.graphics.getWidth()/2 end
	if y == 'mid' then y = love.graphics.getHeight()/2 end

	local radian = radian or 0
	local scale_x = scale_x or 1
	local scale_y = scale_y or 1

	love.graphics.draw(image, x, y,
		radian, scale_x, scale_y,
		image:getWidth()/2, image:getHeight()/2)
end

function Jutils.print(string, x, y, font, relativePrint, alignment, r, scale_x, scale_y, shearing_x, shearing_y, limit)

	local x = x or 0
	local y = y or 0
	local font = font or love.graphics.newFont(vera_ttf, 12)
	local relativePrint = relativePrint or false
	local r = r or 0
	local scale_x = scale_x or 1
	local scale_y = scale_y or 1
	local shearing_x = shearing_x or 0
	local shearing_y = shearing_y or 0
	local limit = limit or font:getWidth(string)

	local alignment = alignment or 'center'
	if alignment ~= 'center' and alignment ~= 'left' and alignment ~= 'right' then
		error("Invalid alignment, must be 'left', 'right', or 'center'.")
	end

	if relativePrint and x ~= 'mid' then x = gRes.w * x end
	if relativePrint and y ~= 'mid' then y = gRes.h * y end
	-- if x == 'mid' then x = gRes.w/2 end
	-- if y == 'mid' then y = gRes.h/2 end

	love.graphics.setFont(font)
	love.graphics.printf(
		string, x, y,
		limit, alignment, -- limit, alignment
		r, scale_x, scale_y, -- angle, scale x and scale y
		font:getWidth(string)/2,
		font:getHeight(string)/2,
		shearing_x, shearing_y -- no shearing support
		)
end



function Jutils.setOpa(opa)
	love.graphics.setColor(255,255,255,opa)
end

Jutils.__index = Jutils
return Jutils