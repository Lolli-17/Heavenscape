local K = require("src.constants")

local Weapon = {}

function Weapon.create(damage, fireRate, speed, size)
	local newWeapon = {
		damage = damage,
		fireRate = fireRate,
		speed = speed,
		size = size,
		timer = 0,
	}

	return newWeapon
end

return Weapon