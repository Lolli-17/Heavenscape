local K = require("src.constants")

local Player = {}

function Player.load()
	Player.x = K.SCREEN.CENTER_X - K.PLAYER.SIZE / 2
	Player.y = K.SCREEN.CENTER_Y - K.PLAYER.SIZE / 2
	Player.size = K.PLAYER.SIZE
	Player.speed = K.PLAYER.SPEED
	Player.health = K.PLAYER.HEALTH
end

function Player.update(dt)
	if love.keyboard.isDown("right") and Player.x < (K.SCREEN_WIDTH - Player.size) then
		Player.x = Player.x + (Player.speed * dt)
	elseif love.keyboard.isDown("left") and Player.x > (0) then
		Player.x = Player.x - (Player.speed * dt)
	end
	if love.keyboard.isDown("down") and Player.y < (K.SCREEN_HEIGHT - Player.size) then
		Player.y = Player.y + (Player.speed * dt)
	elseif love.keyboard.isDown("up") and Player.y > (0) then
		Player.y = Player.y - (Player.speed * dt)
	end
end

function Player.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", Player.x, Player.y, Player.size, Player.size)
end

return Player