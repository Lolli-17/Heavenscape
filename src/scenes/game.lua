-- src/scenes/game.lua
local K = require("src.constants")
local enemy_list = require("src.entities.enemy_list")
local bullet_list = require("src.entities.bullet_list")
local player = require("src.entities.player")
require("src.utils")

local Game = {}

function Game.load()
	player.load()
end

function Game.update(dt)
	player.update(dt)
	bullet_list.update(dt)
	enemy_list.update(dt, player)

	for i = #bullet_list.list, 1, -1 do
		local bullet = bullet_list.list[i]
		for j = #enemy_list.list, 1, -1 do
			local enemy = enemy_list.list[j]
			if checkCollision(
				bullet.x,
				bullet.y,
				bullet.size,
				bullet.size,
				enemy.x,
				enemy.y,
				enemy.size,
				enemy.size
			) then
				table.remove(bullet_list.list, i)
				table.remove(enemy_list.list, j)
				break
			end
		end
	end
end

function Game.draw()
	player.draw()
	enemy_list.draw()
	bullet_list.draw()
end

return Game