local K = require("src.constants")
local drop_manager = require("src.entities.drop_manager")
require("src.utils")

local EnemyManager = {}
EnemyManager.timer = 0
EnemyManager.spawnRate = K.ENEMY.SPAWN_RATE


function EnemyManager.load(world)
	EnemyManager.world = world
	EnemyManager.list = {}
end

function EnemyManager.spawn(centerX, centerY)
	local margin = 100
	local side = math.random(4)

	local x, y

	if side == 1 then -- sopra
		x = centerX + math.random(-K.SCREEN.WIDTH / 2, K.SCREEN.WIDTH / 2)
		y = centerY - K.SCREEN.HEIGHT / 2 - margin
	elseif side == 2 then -- sotto
		x = centerX + math.random(-K.SCREEN.WIDTH / 2, K.SCREEN.WIDTH / 2)
		y = centerY + K.SCREEN.HEIGHT / 2 + margin
	elseif side == 3 then -- sinistra
		x = centerX - K.SCREEN.WIDTH / 2 - margin
		y = centerY + math.random(-K.SCREEN.HEIGHT / 2, K.SCREEN.HEIGHT / 2)
	else -- destra
		x = centerX + K.SCREEN.WIDTH / 2 + margin
		y = centerY + math.random(-K.SCREEN.HEIGHT / 2, K.SCREEN.HEIGHT / 2)
	end

	local newEnemy = {
		x = x,
		y = y,
		size = math.random(K.ENEMY.MIN_SIZE, K.ENEMY.MAX_SIZE),
		speed = math.random(K.ENEMY.MIN_SPEED, K.ENEMY.MAX_SPEED),
		health = 10,
		type = "enemy",
	}

	table.insert(EnemyManager.list, newEnemy)
	EnemyManager.world:add(newEnemy, newEnemy.x, newEnemy.y, newEnemy.size, newEnemy.size)
end

function EnemyManager.target(player)
	local closestEnemy = nil
	local recordDistance = math.huge

	for i, enemy in ipairs(EnemyManager.list) do
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

function EnemyManager.update(dt, player)
	EnemyManager.timer = EnemyManager.timer + dt

	for i = #EnemyManager.list, 1, -1 do
		local enemy = EnemyManager.list[i]

		local function enemyFilter(item, other)
			if other.type == "drop" then
				return "cross"
			elseif other.type == "player" then
				return "slide"
			end

			return nil
		end

		if enemy.health <= 0 then
			drop_manager.spawn(enemy.x, enemy.y)

			EnemyManager.world:remove(enemy)
			table.remove(EnemyManager.list, i)

			break
		end

		local dx = player.x - enemy.x
		local dy = player.y - enemy.y
		local distance = math.sqrt(dx * dx + dy * dy)
		local dirX, dirY = 0, 0
		if distance > 0 then
			dirX = dx / distance
			dirY = dy / distance
		end

		local goalX = enemy.x + (dirX * enemy.speed * dt)
		local goalY = enemy.y + (dirY * enemy.speed * dt)
		local actualX, actualY, cols, len = EnemyManager.world:move(enemy, goalX, goalY, enemyFilter)

		enemy.x = actualX
		enemy.y = actualY

		for j, col in ipairs(cols) do
			if col.other == player then
				player.health = player.health - 1

				EnemyManager.world:remove(enemy)
				table.remove(EnemyManager.list, i)
			end
		end
	end

	if EnemyManager.timer > EnemyManager.spawnRate then
		EnemyManager.spawn(player.centerX, player.centerY)
		EnemyManager.timer = 0
	end
end

function EnemyManager.draw()
	love.graphics.setColor(1, 0, 0)
	for i, enemy in ipairs(EnemyManager.list) do
		love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.size, enemy.size)
	end
end

return EnemyManager