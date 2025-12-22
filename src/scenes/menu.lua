local suit = require("src.libs.suit")

local Menu = {}

function Menu.load()
    
end

function Menu.update(dt)
    suit.layout:reset(100, 100)
	
    if suit.Button("GIOCA", {id=1}, 300, 200, 200, 50).hit then
        return "game"
    end

    if suit.Button("ESCI", {id=2}, 300, 280, 200, 50).hit then
        love.event.quit()
    end
end

function Menu.draw()
    suit.draw()
end

return Menu