local InputManager = {}

local actions = {
	up = {"up", "w"},
	down = {"down", "s"},
	left = {"left", "a"},
	right = {"right", "d"},
}

function InputManager.check(input)
	local keys = actions[input]

	for i, key in ipairs(keys) do
		if love.keyboard.isDown(key) then
			return true
		end
	end
	
	return false
end

return InputManager