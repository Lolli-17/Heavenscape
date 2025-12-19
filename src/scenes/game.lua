-- src/scenes/game.lua
local K = require("src.constants")
local enemy_list = require("src.entities.enemy_list")
local bullet_list = require("src.entities.bullet_list")
local player = require("src.entities.player")
local collision_manager = require("src.managers.collision_manager")
local camera = require("src.utils.camera")
local map = require("src.entities.map")
require("src.utils")

local Game = {}

function Game.load()
	player.load()
	map.load()
	camera:lookAt(player.centerX, player.centerY)
end

function Game.update(dt)
	player.update(dt)

	local lerp_speed = 10
	local nuova_x = camera.x + (player.centerX - camera.x) * lerp_speed * dt
	local nuova_y = camera.y + (player.centerY - camera.y) * lerp_speed * dt
	camera:lookAt(nuova_x, nuova_y)
	bullet_list.update(dt)
	enemy_list.update(dt, player)
	collision_manager.update(player, enemy_list, bullet_list)
	map.update()
end

function Game.draw()
	camera:attach()
	map.draw()
	player.draw()
	enemy_list.draw()
	bullet_list.draw()
	camera:detach()
	love.graphics.print("HP: " .. player.health, 10, 10)
end

return Game