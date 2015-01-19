-- Roadie handles things below the main playground
Roadie = {}

function Roadie:init()
	self.alive = {}
	initStars()
end

function Roadie:update(dt)
	for i, object in ipairs(Roadie.alive) do
		if not object.alive then
			table.remove(Roadie.alive, i)
		else
			object:update(dt)
		end
	end
end

function Roadie:draw()
	for i, object in ipairs(Roadie.alive) do
		object:draw(dt)
	end
end