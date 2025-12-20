local camera = require("src.utils.camera")
local K = require("src.constants")

local Map = {}

function Map.load()
	Map.start_x = 0
	Map.end_x = 0
	Map.start_y = 0
	Map.end_y = 0
	Map.horizontal_start_index = 0
	Map.horizontal_end_index = 0
	Map.vertical_start_index = 0
	Map.vertical_end_index = 0
end

function Map.update(dt)
	Map.start_x = camera.x - (K.SCREEN.WIDTH / 2)
	Map.end_x = camera.x + (K.SCREEN.WIDTH / 2)
	Map.start_y = camera.y - (K.SCREEN.HEIGHT / 2)
	Map.end_y = camera.y + (K.SCREEN.HEIGHT / 2)
	Map.horizontal_start_index = math.floor(Map.start_x / K.MAP.CELL)
	Map.horizontal_end_index = math.floor(Map.end_x / K.MAP.CELL)
	Map.vertical_start_index = math.floor(Map.start_y / K.MAP.CELL)
	Map.vertical_end_index = math.floor(Map.end_y / K.MAP.CELL)
end

function Map.draw()
	love.graphics.setColor(0.1, 0.2, 0.4, 1)
	for i = Map.horizontal_start_index, Map.horizontal_end_index, 1 do
		love.graphics.line(i * K.MAP.CELL, Map.start_y, i * K.MAP.CELL, Map.end_y)
	end
	for i = Map.vertical_start_index, Map.vertical_end_index, 1 do
		love.graphics.line(Map.start_x, i * K.MAP.CELL, Map.end_x, i * K.MAP.CELL)
	end
end

return Map