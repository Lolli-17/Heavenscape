-- src/collision_manager.lua
require("src.utils") -- Assumiamo che checkCollision sia qui

local CollisionManager = {}

function CollisionManager.update(player, enemy_module, bullet_module)
    local enemies = enemy_module.list
    local bullets = bullet_module.list

    for i = #bullets, 1, -1 do
        local bullet = bullets[i]
        for j = #enemies, 1, -1 do
            local enemy = enemies[j]
            if checkCollision(bullet.x, bullet.y, bullet.size, bullet.size, enemy.x, enemy.y, enemy.size, enemy.size) then
                table.remove(enemies, j)
                table.remove(bullets, i)
                break
            end
        end
    end

    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        if checkCollision(player.x, player.y, player.size, player.size, enemy.x, enemy.y, enemy.size, enemy.size) then
            
            player.health = player.health - 1
            table.remove(enemies, i)
        end
    end
end

return CollisionManager