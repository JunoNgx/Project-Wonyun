function spawnFormation(formaCode)
	-- function spawnKeadani(unitType, x, y, r)

	if formaCode == 1001 then
		-- Three random riley from above
		spawnKeadani(1, love.math.random(0,gRes.w), love.math.random(-300,0), math.pi/2)
		spawnKeadani(1, love.math.random(0,gRes.w), love.math.random(-300,0), math.pi/2)
		spawnKeadani(1, love.math.random(0,gRes.w), love.math.random(-300,0), math.pi/2)

	elseif formaCode == 1002 then
		-- Four Rileys in straight row
		for i = 1, 4 do
			spawnKeadani(1, 256 * i, -200, math.pi/2)
		end
		
	elseif formaCode == 1003 then
		-- Five rileys in delta formation
		spawnKeadani(1, 200, -350, math.pi/2)
		spawnKeadani(1, 420, -250, math.pi/2)
		spawnKeadani(1, 640, -150, math.pi/2)
		spawnKeadani(1, 860, -250, math.pi/2)
		spawnKeadani(1, 1080, -350, math.pi/2)

	elseif formaCode == 1204 then
		-- Four rileys approaching in primrose formation
		spawnKeadani(1, gRes.w * 0.75, gRes.h * -0.25, math.pi/2)
		spawnKeadani(1, gRes.w * 1.25, gRes.h * 0.75, math.pi)
		spawnKeadani(1, gRes.w * 0.25, gRes.h * 1.25, -math.pi/2)
		spawnKeadani(1, gRes.w * -0.25, gRes.h * 0.25, 0)

	elseif formaCode == 1205 then
		-- Four rileys approaching horizontally
		spawnKeadani(1, gRes.w * 1.25, gRes.h * 0.2, math.pi)
		spawnKeadani(1, gRes.w * -0.25, gRes.h * 0.4, 0)
		spawnKeadani(1, gRes.w * -0.25, gRes.h * 0.6, 0)
		spawnKeadani(1, gRes.w * 1.25, gRes.h *0.8, math.pi)

	elseif formaCode == 1107 then
		-- Three rileys approaching from below
		spawnKeadani(1, gRes.w * 0.75, gRes.h * 1.20, -math.pi/2)
		spawnKeadani(1, gRes.w * 0.50, gRes.h * 1.25, -math.pi/2)
		spawnKeadani(1, gRes.w * 0.25, gRes.h * 1.20, -math.pi/2)

	elseif formaCode == 2001 then
		-- Two dulces coming diagonally from above
		spawnKeadani(2, gRes.w * 0.0, gRes.h * -0.25, math.pi/4)
		spawnKeadani(2, gRes.w * 1.0, gRes.h * -0.25, math.pi*3/4)

	elseif formaCode == 2101 then
		-- Two dulces coming diagonally from below
		spawnKeadani(2, gRes.w * 0.0, gRes.h * 1.25, -math.pi/4)
		spawnKeadani(2, gRes.w * 1.0, gRes.h * 1.25, -math.pi*3/4)

	elseif formaCode == 2002 then
		-- Two dulces coming vertically from above
		spawnKeadani(2, gRes.w * 0.3, -300, math.pi/2)
		spawnKeadani(2, gRes.w * 0.7, -300, math.pi/2)

	elseif formaCode == 2102 then
		-- Two dulces coming vertically from below
		spawnKeadani(2, gRes.w * 0.3, gRes.h * 1.25, -math.pi/2)
		spawnKeadani(2, gRes.w * 0.7, gRes.h * 1.25, -math.pi/2)

	elseif formaCode == 3001 then
		-- Two augustus in a row
		spawnKeadani(3, gRes.w * 0.3, -200, math.pi/2)
		spawnKeadani(3, gRes.w * 0.6, -200, math.pi/2)

	elseif formaCode == 3002 then
		-- Three augustus in reversed delta
		spawnKeadani(3, gRes.w * 0.25, -200, math.pi/2)
		spawnKeadani(3, gRes.w * 0.50, -400, math.pi/2)
		spawnKeadani(3, gRes.w * 0.75, -200, math.pi/2)

	elseif formaCode == 3303 then
		-- Two augustus from left
		spawnKeadani(3, gRes.w * -0.25, gRes.h * 0.3, 0)
		spawnKeadani(3, gRes.w * -0.25, gRes.h * 0.7, 0)

	elseif formaCode == 3404 then
		-- Two augustus from right
		spawnKeadani(3, gRes.w * 1.25, gRes.h * 0.3, -math.pi)
		spawnKeadani(3, gRes.w * 1.25, gRes.h * 0.7, -math.pi)

	elseif formaCode == 4000 then
		-- Three randomly generated hammerhead
		spawnKeadani(4, love.math.random(0,gRes.w), love.math.random(-300,-100), math.pi/2)
		spawnKeadani(4, love.math.random(0,gRes.w), love.math.random(-300,-100), math.pi/2)
		spawnKeadani(4, love.math.random(0,gRes.w), love.math.random(-300,-100), math.pi/2)

	elseif formaCode == 4001 then
		-- Two aligned hammerhead from above
		spawnKeadani(4, gRes.w * 0.3, love.math.random(-300,-100), math.pi/2)
		spawnKeadani(4, gRes.w * 0.7, love.math.random(-300,-100), math.pi/2)

	elseif formaCode == 4101 then
		-- Two aligned hammerhead from below
		spawnKeadani(4, gRes.w * 0.3, gRes.h + love.math.random(50,120), -math.pi/2)
		spawnKeadani(4, gRes.w * 0.7, gRes.h + love.math.random(50,120), -math.pi/2)		

	elseif formaCode == 5000  then
		-- A hovering Koltar on the upper half of the screen, from right to left
		spawnKeadani(5, gRes.w * 1.25, gRes.h * 0.75, -math.pi*5/6)		

	elseif formaCode == 5001  then
		-- A hovering Koltar on the upper half of the screen, from left to right
		spawnKeadani(5, gRes.w * -0.25, gRes.h * 0.75, -math.pi*1/6)	

	elseif formaCode == 7001 then
		-- one riley and Two augustus from above
		spawnKeadani(3, gRes.w * 0.3, -150, math.pi/2)
		spawnKeadani(1, gRes.w * 0.5, -200, math.pi/2)
		spawnKeadani(3, gRes.w * 0.7, -150, math.pi/2)

	elseif formaCode == 7002 then
		-- two diagonal dulces One hammerhead and 
		spawnKeadani(2, gRes.w * 0.0, gRes.h * 1.25, -math.pi/6)
		spawnKeadani(4, gRes.w * 0.5, -150, math.pi/2)
		spawnKeadani(2, gRes.w * 1.0, gRes.h * 1.25, -math.pi*5/6)
	elseif formaCode == 7003 then
		-- Two riley and two dulces
		spawnKeadani(4, gRes.w * 0.15, -200, math.pi/2)
		spawnKeadani(2, gRes.w * 0.4, -200, math.pi/2)
		spawnKeadani(2, gRes.w * 0.6, -200, math.pi/2)
		spawnKeadani(4, gRes.w * 0.85, -200, math.pi/2)

	elseif formaCode == 7104 then
		-- Two rileys, one augustus in delta from below
		spawnKeadani(1, gRes.w * 0.3, gRes.h + 200, -math.pi/2)
		spawnKeadani(3, gRes.w * 0.5, gRes.h + 150, -math.pi/2)
		spawnKeadani(1, gRes.w * 0.7, gRes.h + 200, -math.pi/2)

	elseif formaCode == 7005 then
		-- One riley and one dulce
		spawnKeadani(1, gRes.w * 0.4, -200, math.pi/2)
		spawnKeadani(2, gRes.w * 1.1, gRes.h + 50, -math.pi*3/4)

	elseif formaCode == 7006 then
		-- One riley (from right to left) and one augustus
		spawnKeadani(1, gRes.w * 1.2, gRes.h * 0.7, -math.pi)
		spawnKeadani(3, gRes.w * 0.5, -100, math.pi/2)

	elseif formaCode == 7007 then
		-- [random] One hammerhead and two riley
		spawnKeadani(4, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)
		spawnKeadani(1, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)
		spawnKeadani(1, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)

	elseif formaCode == 7008 then
		-- One random hammerhead and one augustus
		spawnKeadani(3, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)
		spawnKeadani(4, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)

	elseif formaCode == 7601 then
		-- Two riley, [random] one augustus, [random] one dulce [from right to left]
		spawnKeadani(1, gRes.w * 0.2, -200, -math.pi/2)
		spawnKeadani(1, gRes.w * 0.8, -200, -math.pi/2)
		spawnKeadani(3, love.math.random(0, gRes.w), love.math.random(-150, -50), math.pi/2)
		spawnKeadani(2, -100, love.math.random(0, gRes.h), 0)

	elseif formaCode == 7602 then
		-- One augustus, two dulce, one hammerhead
		spawnKeadani(3, gRes.w * 0.3, love.math.random(-150, -50), math.pi/2)
		spawnKeadani(4, gRes.w * 0.7, love.math.random(-150, -50), math.pi/2)
		spawnKeadani(2, -100, love.math.random(0, gRes.h), 0)
		spawnKeadani(2, gRes.w + 100, love.math.random(0, gRes.h), math.pi)

	elseif formaCode == 7603 then
		-- One riley, one augustus, one dulce, one hammerhead in a column
		column = love.math.random(gRes.w * 0.2, gRes.w * 0.8)
		spawnKeadani(3, column, -50, math.pi/2)
		spawnKeadani(1, column, -170, math.pi/2)
		spawnKeadani(4, column, -290, math.pi/2)
		spawnKeadani(2, column, -420, math.pi/2)

	elseif formaCode == 7701 then
		-- Koltar and one riley straight middle
		spawnKeadani(5, gRes.w * 0.5, -200, math.pi/2)
		spawnKeadani(1, gRes.w * 0.5, -50, math.pi/2)

	elseif formaCode == 7702 then
		-- Koltar and [semi-random] one dulce
		column = love.math.random(gRes.w * 0.3, gRes.w * 0.7)
		spawnKeadani(5, column, -200, math.pi/2)
		spawnKeadani(2, column + love.math.random(-100,100), -50, math.pi/2)

	-- elseif formaCode == 7703 then
	-- 	-- Koltar and 

	elseif formaCode == 7704 then
		-- Two koltars from mid-lateral, retreating to mid-below
		spawnKeadani(5, gRes.w * 1.25, gRes.h * 0.75, -math.pi*5/6)		
		spawnKeadani(5, gRes.w * -0.25, gRes.h * 0.75, -math.pi*1/6)	

	-- elseif formaCode == 7705 then

	elseif formaCode == 9999 then
		-- Randomly generated five keadani
		for i=1, 5 do
			spawnKeadani(love.math.random(1,5), love.math.random(0,gRes.w), love.math.random(-300,-100), math.pi/2)
		end
	end

end

spawnCodeList = {
	1001,
	1002,
	1003,
	1204,
	1205,
	1107,
	2001,
	2101,
	2002,
	2102,
	3001,
	3002,
	3303,
	3404,
	4000,
	4001,
	4101,
	5000,
	5001,
	7001,
	7002,
	7003,
	7104,
	7005,
	7006,
	7007,
	7008,
	7601,
	7602,
	7603,
	7701,
	7702,
	7704,
	9999,
}