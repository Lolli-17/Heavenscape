local Constants = {
	SCREEN = {
		WIDTH = 800,
		HEIGHT = 600,
	},
	PLAYER = {
		SIZE = 30,
		SPEED = 200,
		HEALTH = 3,
	},
	BULLET = {
		SIZE = 8,
		SPEED = 400,
		COOLDOWN = 0.5,
	},
	ENEMY = {
		MIN_SIZE = 25,
		MAX_SIZE = 45,
		MIN_SPEED = 90,
		MAX_SPEED = 150,
	},
}

Constants.SCREEN.CENTER_X = Constants.SCREEN.WIDTH / 2
Constants.SCREEN.CENTER_Y = Constants.SCREEN.HEIGHT / 2

return Constants