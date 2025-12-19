local game = require("src.scenes.game")
local menu = require("src.scenes.menu")

local gameState = "menu"

function love.load()
    game.load()
end

function love.update(dt)
    if gameState == "menu" then
        local nextState = menu.update(dt)
		
        if nextState then
            gameState = nextState
        end

    elseif gameState == "game" then
        game.update(dt)
    end
end

function love.draw()
    if gameState == "menu" then
        menu.draw()
    elseif gameState == "game" then
        game.draw()
    end
end