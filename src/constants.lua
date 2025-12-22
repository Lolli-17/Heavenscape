local Constants = {
	DROP = {
		PICKUP_RADIUS = 20,
		SIZE = 10,
		SPEED = 225,
	},
	ENEMY = {
		MIN_SIZE = 25,
		MAX_SIZE = 45,
		MIN_SPEED = 90,
		MAX_SPEED = 150,
		SPAWN_RATE = 0.8,
	},
	MAP = {
		CELL = 180
	},
	PLAYER = {
		SIZE = 30,
		SPEED = 200,
		HEALTH = 3,
	},
	SCREEN = {
		WIDTH = 800,
		HEIGHT = 600,
	},
	WEAPON = {
		PISTOL = {
			DAMAGE = 20,
			FIRE_RATE = 1,
			SPEED = 400,
			SIZE = 8
		},
	},
}

Constants.SCREEN.CENTER_X = Constants.SCREEN.WIDTH / 2
Constants.SCREEN.CENTER_Y = Constants.SCREEN.HEIGHT / 2

return Constants