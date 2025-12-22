local K = require("src.constants")
local enemy_manager = require("src.entities.enemy_manager")
local bullet_manager = require("src.entities.bullet_manager")
local input_manager = require("src.managers.input_manager")
local weapon = require("src.weapon")

local Player = {}

function Player.load(world)
	Player.x = K.SCREEN.CENTER_X - K.PLAYER.SIZE / 2
	Player.y = K.SCREEN.CENTER_Y - K.PLAYER.SIZE / 2
	Player.size = K.PLAYER.SIZE
	Player.centerX = Player.x + Player.size / 2
	Player.centerY = Player.y + Player.size / 2
	Player.speed = K.PLAYER.SPEED
	Player.health = K.PLAYER.HEALTH
	Player.type = "player"
	Player.world = world
	Player.xp = 0
	Player.xpToLevelUp = 1
	Player.level = 1
	Player.levelUpReady = false

	Player.world:add(Player, Player.x, Player.y, Player.size, Player.size)

	Player.weapon = weapon.create(
		K.WEAPON.PISTOL.DAMAGE,
		K.WEAPON.PISTOL.FIRE_RATE,
		K.WEAPON.PISTOL.SPEED,
		K.WEAPON.PISTOL.SIZE
	)
end

function Player.update(dt)
	Player.weapon.timer = Player.weapon.timer + dt
	if Player.weapon.timer > Player.weapon.fireRate then
		local nearestEnemy = enemy_manager.target(Player)
		if nearestEnemy ~= nil then
			local dx = nearestEnemy.x - Player.x
			local dy = nearestEnemy.y - Player.y
			local distance = math.sqrt(dx * dx + dy * dy)
			local dirX, dirY = 0, 0
			if distance > 0 then
				dirX = dx / distance
				dirY = dy / distance
			end
			
			bullet_manager.spawn(Player.centerX, Player.centerY, dirX, dirY, Player.weapon)
		end

		Player.weapon.timer = Player.weapon.timer - Player.weapon.fireRate
	end

	local dx, dy = 0, 0

	if input_manager.check("right") then
		dx = Player.speed * dt
	elseif input_manager.check("left") then
		dx = -(Player.speed * dt)
	end
	if input_manager.check("down") then
		dy = Player.speed * dt
	elseif input_manager.check("up") then
		dy = -(Player.speed * dt)
	end

	local function playerFilter(item, other)
		if other.type == "bullet" then 
				return nil
		elseif other.type == "drop" then
			return "cross"
		end

		return "slide"
	end

	if dx ~= 0 or dy ~= 0 then
		local goalX = Player.x + dx
        local goalY = Player.y + dy

        local actualX, actualY, cols, len = Player.world:move(Player, goalX, goalY, playerFilter)

        Player.x = actualX
        Player.y = actualY
	end

	Player.centerX = Player.x + Player.size / 2
	Player.centerY = Player.y + Player.size / 2

	if Player.xp >= Player.xpToLevelUp then
		Player.level = Player.level + 1
		Player.xp = Player.xp - Player.xpToLevelUp
		Player.xpToLevelUp = Player.xpToLevelUp + 1

		Player.levelUpReady = true
	end
end

function Player.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", Player.x, Player.y, Player.size, Player.size)
end

return Player