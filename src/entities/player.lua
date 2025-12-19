local K = require("src.constants")
local enemy_list = require("src.entities.enemy_list")
local bullet_list = require("src.entities.bullet_list")
local input_manager = require("src.managers.input_manager")

local Player = {}
local fireTimer = 0
local bullet_cooldown = K.BULLET.COOLDOWN

function Player.load()
	Player.x = K.SCREEN.CENTER_X - K.PLAYER.SIZE / 2
	Player.y = K.SCREEN.CENTER_Y - K.PLAYER.SIZE / 2
	Player.size = K.PLAYER.SIZE
	Player.centerX = Player.x + Player.size / 2
	Player.centerY = Player.y + Player.size / 2
	Player.speed = K.PLAYER.SPEED
	Player.health = K.PLAYER.HEALTH
end

function Player.update(dt)
	fireTimer = fireTimer + dt
	if fireTimer > bullet_cooldown then
		local nearestEnemy = enemy_list.target(Player)
		if nearestEnemy ~= nil then
			local dx = nearestEnemy.x - Player.x
			local dy = nearestEnemy.y - Player.y
			local distance = math.sqrt(dx * dx + dy * dy)
			local dirX, dirY = 0, 0
			if distance > 0 then
				dirX = dx / distance
				dirY = dy / distance
			end
			
			bullet_list.spawn(Player.centerX, Player.centerY, dirX, dirY)
		end

		fireTimer = 0
	end

	if input_manager.check("right") then
		Player.x = Player.x + (Player.speed * dt)
	elseif input_manager.check("left") then
		Player.x = Player.x - (Player.speed * dt)
	end
	if input_manager.check("down") then
		Player.y = Player.y + (Player.speed * dt)
	elseif input_manager.check("up") then
		Player.y = Player.y - (Player.speed * dt)
	end

	Player.centerX = Player.x + Player.size / 2
	Player.centerY = Player.y + Player.size / 2
end

function Player.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", Player.x, Player.y, Player.size, Player.size)
end

return Player