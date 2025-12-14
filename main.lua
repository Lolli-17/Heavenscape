function love.load()
    player = {
        x = 400 - 15,
        y = 300 - 15,
        size = 30,
        speed = 200,
    }
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + (player.speed * dt)
    elseif love.keyboard.isDown("left") then
        player.x = player.x - (player.speed * dt)
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + (player.speed * dt)
    elseif love.keyboard.isDown("up") then
        player.y = player.y - (player.speed * dt)
    end
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end
