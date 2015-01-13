-- require 'entities/bullet_f'

Pool = {
	bullet_f = {},
}

function Pool:init()
	for i = 1, 20 do
		local bullet_f = Bullet_f()
		table.insert(Pool.bullet_f, bullet_f)
	end
end

function Pool:update(dt)
	
end

function Pool:draw()

end