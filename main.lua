local game = require("src.scenes.game")
local menu = require("src.scenes.menu")
local level_up = require("src.scenes.level_up")

local gameState = "menu"

function love.load()
    menu.load()
    game.load()
    level_up.load()
end

function love.update(dt)
    if gameState == "menu" then
        local nextState = menu.update(dt)

        if nextState then
            gameState = nextState
        end

    elseif gameState == "game" then
        gameState = game.update(dt)
    elseif gameState == "levelUp" then
        gameState = level_up.update(dt)
    end
end

function love.draw()
    if gameState == "menu" then
        menu.draw()
    elseif gameState == "game" then
        game.draw()
    elseif gameState == "levelUp" then
        game.draw()
        level_up.draw()
    end
end