local K = require("src.constants")
require("src.utils")

local EnemyList = {}
EnemyList.list = {}
EnemyList.timer = 0

function EnemyList.spawn(centerX, centerY)
	local newEnemy = {
		x = centerX + (K.SCREEN.WIDTH * 0.75 * math.cos(math.random() * (2 * math.pi))),
		y = centerY + (K.SCREEN.WIDTH * 0.75 * math.sin(math.random() * (2 * math.pi))),
		size = math.random(K.ENEMY.MIN_SIZE, K.ENEMY.MAX_SIZE),
		speed = math.random(K.ENEMY.MIN_SPEED, K.ENEMY.MAX_SPEED),
	}

	table.insert(EnemyList.list, newEnemy)
end

function EnemyList.target(player)
	local closestEnemy = nil
	local recordDistance = math.huge

	for i, enemy in ipairs(EnemyList.list) do
		local dx = player.x - enemy.x
		local dy = player.y - enemy.y
		local distance = math.sqrt(dx * dx + dy * dy)

		if distance < recordDistance then
			recordDistance = distance
			closestEnemy = enemy
		end
	end

	return closestEnemy
end

function EnemyList.update(dt, player)
	EnemyList.timer = EnemyList.timer + dt
	
	for i = #EnemyList.list, 1, -1 do
		local enemy = EnemyList.list[i]
		local dx = player.x - enemy.x
		local dy = player.y - enemy.y
		local distance = math.sqrt(dx * dx + dy * dy)
		local dirX, dirY = 0, 0
		if distance > 0 then
			dirX = dx / distance
			dirY = dy / distance
		end

		enemy.x = enemy.x + (dirX * enemy.speed * dt)
		enemy.y = enemy.y + (dirY * enemy.speed * dt)

		if checkCollision(
			player.x,
			player.y,
			player.size,
			player.size,
			enemy.x,
			enemy.y,
			enemy.size,
			enemy.size
		) then
			player.health = player.health - 1
			table.remove(EnemyList.list, i)
		end
	end

	if EnemyList.timer > 1 then
		EnemyList.spawn(player.centerX, player.centerY)
		EnemyList.timer = 0
	end
end

function EnemyList.draw()
	love.graphics.setColor(1, 0, 0)
	for i, enemy in ipairs(EnemyList.list) do
		love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.size, enemy.size)
	end
end

return EnemyList