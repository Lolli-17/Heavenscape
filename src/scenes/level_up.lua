local K = require("src.constants")
local suit = require("src.libs.suit")
local player = require("src.entities.player")
local drop_manager = require("src.entities.drop_manager")

local unpack = table.unpack or unpack

local LevelUp = {}
LevelUp.pool = {
	{
		id = "damage",
		text = "Aumenta il danno",
		action = function ()
			player.weapon.damage = player.weapon.damage + 1
		end,
	},
	{
		id = "speed",
		text = "Aumenta la velocità di movimento",
		action = function ()
			player.speed = player.speed + 25
		end,
	},
	{
		id = "health",
		text = "Recupera la vita",
		action = function ()
			player.health = player.health + 1
		end,
	},
	{
		id = "pickUp",
		text = "Aumenta raggio di raccolta",
		action = function ()
			for i, drop in ipairs(drop_manager.list) do
				drop.pickUpRadius = drop.pickUpRadius + 20
			end
			drop_manager.pickUpRadiusUpgrade = drop_manager.pickUpRadiusUpgrade + 20
		end,
	},
	{
		id = "size",
		text = "Rimpicciolisciti",
		action = function ()
			player.size = player.size - 5
		end,
	},
	{
		id = "fireRate",
		text = "Aumenta la cadenza di fuoco",
		action = function ()
			player.weapon.fireRate = player.weapon.fireRate - 0.1
		end,
	},
	{
		id = "bulletSpeed",
		text = "Aumenta velocità proiettile",
		action = function ()
			player.weapon.speed = player.weapon.speed + 25
		end,
	},
}

LevelUp.options = {}

function LevelUp.generateOptions()
    LevelUp.options = {}

    local tempPool = {unpack(LevelUp.pool)}

    local numeroScelte = 3

    if #tempPool < 3 then numeroScelte = #tempPool end

    for i = 1, numeroScelte do

        local randomIndex = love.math.random(#tempPool)
        table.insert(LevelUp.options, tempPool[randomIndex])
        table.remove(tempPool, randomIndex)
    end
end

function LevelUp.load()
	
end

function LevelUp.update(dt)
	suit.layout:reset(250, 100)

	for i, option in ipairs(LevelUp.options) do
        suit.layout:padding(25, 25)
        
        if suit.Button(option.text, { id=option.id }, suit.layout:row(300, 50)).hit then
            option.action()
            return "game"
        end
    end

	suit.layout:reset()
	return "levelUp"
end

function LevelUp.draw()
	love.graphics.setColor(0, 0.3, 0.3, 0.5)
	love.graphics.rectangle("fill", 0, 0, K.SCREEN.WIDTH, K.SCREEN.HEIGHT)
	suit.draw()
end

return LevelUp