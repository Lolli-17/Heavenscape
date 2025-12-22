local K = require("src.constants")

local UiManager = {}

function UiManager.draw(player)
    local font = love.graphics.getFont()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("HP: " .. player.stats.health, 10, 20)
    
    local levelText = "LV: " .. player.stats.level
    local textWidth = font:getWidth(levelText)
    local xPosition = K.SCREEN.WIDTH - textWidth - 20
    love.graphics.print(levelText, xPosition, 20)
    
    love.graphics.print("XP: " .. player.stats.xp .. "/" .. player.stats.nextLevelXp, 10, 20)

    love.graphics.setColor(0.2, 0.2, 0.2, 1)
    love.graphics.rectangle("fill", 0, 0, K.SCREEN.WIDTH, 10)

    love.graphics.setColor(1, 1, 1, 1)
    local xpRatio = player.stats.xp / player.stats.nextLevelXp
    love.graphics.rectangle("fill", 0, 0, K.SCREEN.WIDTH * xpRatio, 10)
end

return UiManager