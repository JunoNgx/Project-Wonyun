-- Juno's minimal alarm library
-- Very special thanks to Karthik T. of Favorite Medium

Alarm = {}

function Alarm:reset()
	self.events = {}
end

function Alarm:after(timer, funct)
	local event = {
		countdown = timer,
		doStuff = funct,
		-- done = false
	}
	table.insert(self.events, event)
end

function Alarm:update(dt)
	for i, event in ipairs(self.events) do
		if self.events[i] ~= nil then
			local event = self.events[i]

			-- if not event.done then
				if event.countdown > 0 then
					event.countdown = event.countdown - dt
				else
					table.remove(self.events, i)
					event.doStuff()
					event.done = true
				end
			-- end
		end
	end
end

Alarm.__index = Alarm
return Alarm



-- return Alarm = {

-- 	reset = function(self)
-- 		self.events = {}
-- 	end,

-- 	after = function(self, timer, funct)
-- 		local event = {
-- 			countdown = timer,
-- 			doStuff = funct,
-- 			done = false
-- 		}
-- 		table.insert(self.events, event)
-- 	end,

-- 	update = function(self, dt)
-- 		for i, event in ipairs(self.events) do

-- 			local event = self.events[i]

-- 			if not event.done then
-- 				if event.countdown > 0 then
-- 					event.countdown = event.countdown - dt
-- 				else
-- 					doStuff()
-- 					event.done = true

-- 					table.remove(self.events, i)
-- 				end
-- 			end
-- 		end
-- 	end,
-- 	}


-- local Alarm = {}

-- local function reset(self)
-- 	self.events = {}
-- end

-- local function after(self, timer, funct)
-- 	local event = {
-- 		countdown = timer,
-- 		doStuff = funct,
-- 		done = false
-- 	}
-- 	table.insert(self.events, event)
-- end

-- local function update(self, dt)
-- 	for i, event in ipairs(self.events) do

-- 		local event = self.events[i]

-- 		if not event.done then
-- 			if event.countdown > 0 then
-- 				event.countdown = event.countdown - dt
-- 			else
-- 				doStuff()
-- 				event.done = true

-- 				table.remove(self.events, i)
-- 			end
-- 		end
-- 	end
-- end

-- return {
-- 	update = update,
-- 	after = after,
-- 	events = events,
-- 	reset = reset
-- }