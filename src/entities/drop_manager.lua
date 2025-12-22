local K = require("src.constants")

local DropManager = {}

function DropManager.load(world)
	DropManager.world = world
	DropManager.list = {}
	DropManager.pickUpRadiusUpgrade = 0
end

function DropManager.spawn(x, y)
	local newDrop = {
		x = x,
		y = y,
		size = K.DROP.SIZE,
		speed = K.DROP.SPEED,
		pickUpRadius = K.DROP.PICKUP_RADIUS + DropManager.pickUpRadiusUpgrade,
		type = "drop",
	}

	table.insert(DropManager.list, newDrop)
	DropManager.world:add(newDrop, newDrop.x, newDrop.y, newDrop.size, newDrop.size)
end

function DropManager.update(dt, player)
	local function dropFilter(item, other)
		if other.type == "player" then
			return "cross"
		end

		return nil
	end

	for i = #DropManager.list, 1, -1 do
		local drop = DropManager.list[i]

		local dropCenterX = drop.x + drop.size / 2
        local dropCenterY = drop.y + drop.size / 2
        local dx = player.centerX - dropCenterX
        local dy = player.centerY - dropCenterY
		local distance = math.sqrt(dx * dx + dy * dy)
		local dirX, dirY = 0, 0
		if distance > 0 then
			dirX = dx / distance
			dirY = dy / distance
		end

		local goalX = drop.x + (dirX * drop.speed * dt)
		local goalY = drop.y + (dirY * drop.speed * dt)
		local actualX, actualY, cols, len
		if distance < drop.pickUpRadius then
			actualX, actualY, cols, len = DropManager.world:move(drop, goalX, goalY, dropFilter)
			drop.x = actualX
			drop.y = actualY
	
			for j, col in ipairs(cols) do
				if col.other == player then
					player.xp = player.xp + 1
	
					DropManager.world:remove(drop)
					table.remove(DropManager.list, i)
				end
			end
		end
	end
end

function DropManager.draw()
	love.graphics.setColor(1, 0, 1, 1)
	for i, drop in ipairs(DropManager.list) do
		love.graphics.circle("fill", drop.x, drop.y, drop.size / 2)
	end
end

return DropManager