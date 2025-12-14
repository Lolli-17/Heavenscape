local K = require("src.constants")

local EnemyList = {}
EnemyList.list = {}
EnemyList.timer = 0

function EnemyList.spawn()
	local newEnemy = {
        x = math.random(0, K.SCREEN_WIDTH),
        y = math.random(0, K.SCREEN_HEIGHT),
        size = math.random(25, 45),
        speed = math.random(90, 110),
    }

    table.insert(EnemyList.list, newEnemy)
end

function EnemyList.update(dt, player_x, player_y)
	EnemyList.timer = EnemyList.timer + dt

	for i, enemy in ipairs(EnemyList.list) do
        -- if enemy.x < player_x then
        --     enemy.x = enemy.x + (enemy.speed * dt)
        -- elseif enemy.x > player_x then
        --     enemy.x = enemy.x - (enemy.speed * dt)
        -- end
        -- if enemy.y < player_y then
        --     enemy.y = enemy.y + (enemy.speed * dt)
        -- elseif enemy.y > player_y then
        --     enemy.y = enemy.y - (enemy.speed * dt)
        -- end

		dx = player_x - enemy.x
		dy = player_y - enemy.y
		dist = math.sqrt(dx * dx + dy * dy)
		if dist > 0 then
			dirX = dx / dist
			dirY = dy / dist
		end

		enemy.x = enemy.x + (dirX * enemy.speed * dt)
		enemy.y = enemy.y + (dirY * enemy.speed * dt)
    end

    if timer > 2 then
        EnemyList.spawn()
        timer = 0
    end
end

function EnemyList.draw()
    for i, enemy in ipairs(EnemyList.list) do
        love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.size, enemy.size)
    end
end

return EnemyList