-- Utilities functions for keep main functions tidy

function collide(objA, objB)
	return objA.x < objB.x + objB.w and
		objB.x < objA.x + objA.w and
		objA.y < objB.y + objB.h and
		objB.y < objA.y + objA.h
end

function keepInRange(var, min, max)
	if var < min then var = min end
	if var > max then var = max end
end