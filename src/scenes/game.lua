-- src/scenes/game.lua
local K = require("src.constants")
local enemy_manager = require("src.entities.enemy_manager")
local bullet_manager = require("src.entities.bullet_manager")
local player = require("src.entities.player")
local collision_manager = require("src.managers.collision_manager")
local camera = require("src.utils.camera")
local map = require("src.entities.map")
local bump = require("src.libs.bump")
require("src.utils")

local Game = {}

function Game.load()
	Game.world = bump.newWorld(64)
	player.load(Game.world)
	enemy_manager.load(Game.world)
	bullet_manager.load(Game.world)
	map.load()
	camera:lookAt(player.centerX, player.centerY)
end

function Game.update(dt)
	player.update(dt)

	local lerp_speed = 10
	local nuova_x = camera.x + (player.centerX - camera.x) * lerp_speed * dt
	local nuova_y = camera.y + (player.centerY - camera.y) * lerp_speed * dt
	camera:lookAt(nuova_x, nuova_y)
	bullet_manager.update(dt)
	enemy_manager.update(dt, player)
	collision_manager.update(player, enemy_manager, bullet_manager)
	map.update()
end

function Game.draw()
	camera:attach()
	map.draw()
	player.draw()
	enemy_manager.draw()
	bullet_manager.draw()
	camera:detach()
	love.graphics.print("HP: " .. player.health, 10, 10)
end

return Game