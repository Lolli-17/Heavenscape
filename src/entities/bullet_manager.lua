local K = require("src.constants")
local map = require("src.entities.map")
local BulletManager = {}


function BulletManager.load(world)
	BulletManager.world = world
	BulletManager.list = {}
end

function BulletManager.spawn(startX, startY, dirX, dirY, weapon)
	local bullet = {
		x = startX,
		y = startY,
		dirX = dirX,
		dirY = dirY,
		speed = weapon.speed,
		size = weapon.size,
		damage = weapon.damage,
		type = "bullet",
	}
	table.insert(BulletManager.list, bullet)
	BulletManager.world:add(bullet, bullet.x, bullet.y, bullet.size, bullet.size)
end

function BulletManager.update(dt)
	for i = #BulletManager.list, 1, -1 do
		local bullet = BulletManager.list[i]

		local function bulletFilter(item, other)
			if other.type == "player" then 
				return nil
			elseif other.type == "enemy" then
				return "cross"
			end
		end
		
		local goalX = bullet.x + (bullet.dirX * bullet.speed * dt)
		local goalY = bullet.y + (bullet.dirY * bullet.speed * dt)
		local actualX, actualY, cols, len = BulletManager.world:move(bullet, goalX, goalY, bulletFilter)

		bullet.x = actualX
		bullet.y = actualY

		if bullet.x > map.end_x or
		   bullet.x < map.start_x - bullet.size or
		   bullet.y > map.end_y or
		   bullet.y < map.start_y - bullet.size then
			table.remove(BulletManager.list, i)
		end

		for j, col in ipairs(cols) do
			if col.other.type == "enemy" then
				BulletManager.world:remove(bullet)
				table.remove(BulletManager.list, i)
				
				col.other.health = col.other.health - bullet.damage
				
				break
			end
		end
	end
end

function BulletManager.draw()
	love.graphics.setColor(1, 1, 0)

	for i, bullet in ipairs(BulletManager.list) do
		love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.size, bullet.size)
	end
end

return BulletManager