local K = require("src.constants")
local enemy_list = require("src.enemy_list")

function love.load()
    player = {
        x = K.SCREEN_WIDTH / 2 - K.PLAYER_SIZE / 2,
        y = K.SCREEN_HEIGHT / 2 - K.PLAYER_SIZE / 2,
        size = K.PLAYER_SIZE,
        speed = K.PLAYER_SPEED,
    }

    timer = 0
end

function love.update(dt)
    timer = timer + dt

    if love.keyboard.isDown("right") and player.x < (K.SCREEN_WIDTH - player.size) then
        player.x = player.x + (player.speed * dt)
    elseif love.keyboard.isDown("left") and player.x > (0) then
        player.x = player.x - (player.speed * dt)
    end
    if love.keyboard.isDown("down") and player.y < (K.SCREEN_HEIGHT - player.size) then
        player.y = player.y + (player.speed * dt)
    elseif love.keyboard.isDown("up") and player.y > (0) then
        player.y = player.y - (player.speed * dt)
    end

    enemy_list.update(dt, player.x, player.y)
end

function love.draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
    
    love.graphics.setColor(1, 0, 0)
    enemy_list.draw()
end
