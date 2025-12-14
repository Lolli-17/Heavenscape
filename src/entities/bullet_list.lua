local K = require("src.constants")
local BulletList = {}
BulletList.list = {}

function BulletList.spawn(startX, startY, dirX, dirY)
	local bullet = {
		x = startX,
		y = startY,
		dirX = dirX,
		dirY = dirY,
		speed = K.BULLET.SPEED,
		size = K.BULLET.SIZE,
	}
	table.insert(BulletList.list, bullet)
end

function BulletList.update(dt)
	for i = #BulletList.list, 1, -1 do
		local bullet = BulletList.list[i]
		
		bullet.x = bullet.x + (bullet.dirX * bullet.speed * dt)
		bullet.y = bullet.y + (bullet.dirY * bullet.speed * dt)

		if bullet.x > K.SCREEN.WIDTH or
		   bullet.x < -bullet.size or
		   bullet.y > K.SCREEN.HEIGHT or
		   bullet.y < -bullet.size then
			table.remove(BulletList.list, i)
		end
	end
end

function BulletList.draw()
	love.graphics.setColor(1, 1, 0)
	
	for i, bullet in ipairs(BulletList.list) do
		love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.size, bullet.size)
	end
end

return BulletList