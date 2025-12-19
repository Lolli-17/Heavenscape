-- src/scenes/game.lua
local K = require("src.constants")
local enemy_list = require("src.entities.enemy_list")
local bullet_list = require("src.entities.bullet_list")
local player = require("src.entities.player")
local collision_manager = require("src.managers.collision_manager")
require("src.utils")

local Game = {}

function Game.load()
	player.load()
end

function Game.update(dt)
	player.update(dt)
	bullet_list.update(dt)
	enemy_list.update(dt, player)
	collision_manager.update(player, enemy_list, bullet_list)
end

function Game.draw()
	player.draw()
	enemy_list.draw()
	bullet_list.draw()
	love.graphics.print("HP: " .. player.health, 10, 10)
end

return Game