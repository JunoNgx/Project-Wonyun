function spawnUpdate(dt)


end


function spawnFormation(formaCode)
	-- function spawnKeadani(unitType, x, y, r)

	if formaCode == 1001 then
		-- Three random riley from above

	elseif formaCode == 1002 then
		-- Four Rileys in straight row
		for i = 1, 4 do
			spawnKeadani(1, 256 * i, -200, math.pi/2)
		end
		
	elseif formaCode == 1003 then
		-- Five rileys in delta formation
		spawnKeadani(1, 213, -350, math.pi/2)
		spawnKeadani(1, 426, -250, math.pi/2)
		spawnKeadani(1, 693, -150, math.pi/2)
		spawnKeadani(1, 852, -250, math.pi/2)
		spawnKeadani(1, 1065, -350, math.pi/2)

	elseif formaCode == 1204 then
		-- Four rileys approaching in primrose formation
		spawnKeadani(1, gRes.w * 0.75, gRes.h * -0.25, math.pi/2)
		spawnKeadani(1, gRes.w * 1.25, gRes.h * 0.75, math.pi)
		spawnKeadani(1, gRes.w * 0.25, gRes.h * 1.25, -math.pi/2)
		spawnKeadani(1, gRes.w * -0.25, gRes.h * 0.25, 0)

	elseif formaCode == 1205 then
		-- Four rileys approaching horizontally

	elseif formaCode == 1107 then
		-- Three rileys approaching from below

	elseif formaCode == 2001 then
		-- Two augustus in a row
		spawnKeadani(2, gRes.w * 0.3, -200, math.pi/2)
		spawnKeadani(2, gRes.w * 0.6, -200, math.pi/2)

	elseif formaCode == 2002 then
		-- Three augustus in reversed delta
		spawnKeadani(2, gRes.w * 0.25, -200, math.pi/2)
		spawnKeadani(2, gRes.w * 0.50, -400, math.pi/2)
		spawnKeadani(2, gRes.w * 0.75, -200, math.pi/2)

	elseif formaCode == 2303 then
		-- Two augustus from left

	elseif formaCode == 2404 then
		-- Two augustus from right

	elseif formaCode == 3001 then
		-- Two dulces coming diagonally from above

	elseif formaCode == 3101 then
		-- Two dulces coming diagonally from below

	elseif formaCode == 3002 then
		-- Two dulces coming vertically from above

	elseif formaCode == 3102 then
		-- Two dulces coming vertically from below

	elseif formaCode == 4000 then
		-- Three randomly generated hammerhead

	elseif formaCode == 4001 then
		-- Two aligned hammerhead from above

	elseif formaCode == 4101 then
		-- Two aligned hammerhead from below

	elseif formaCode == 5000  then
		-- A hovering Koltar on the upper half of the screen

	elseif formaCode == 7001 then
		-- one riley and Two augustus  from above

	elseif formaCode == 7002 then
		-- two diagonal dulces One hammerhead and 

	elseif formaCode == 7003 then
		-- Two riley and two dulces

	elseif formaCode == 7104 then
		-- Two rileys, one augustus in delta from below

	elseif formaCode ==  then -- 23
		-- One riley and one dulce

	elseif formaCode ==  then -- 24
		-- One riley and one augustus

	elseif formaCode ==  then
		-- One hammerhead and two riley

	elseif formaCode ==  then
		-- One random hammerhead and one augustus

	elseif formaCode ==  then
		-- Two riley, one augustus, one dulce

	elseif formaCode ==  then
		-- One augustus, two dulce, one hammerhead

	elseif formaCode ==  then
		-- One riley, one augustus, one dulce, one hammerhead in a column

	elseif formaCode ==  then
		-- Koltar and one riley straight middle
	elseif formaCode ==  then
		-- Koltar and one dulce
	elseif formaCode ==  then
		-- Koltar and 
	elseif formaCode ==  then
		-- Two koltars from mid-lateral, retreating to mid-below
	elseif formaCode ==  then

	elseif formaCode == 9999 then
		-- Randomly generated seven keadani

	end

end

spawnCode = {

}