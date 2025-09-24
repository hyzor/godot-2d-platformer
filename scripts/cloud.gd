extends Node2D

@export var speed: float = 50.0

func _process(delta):
	position.x -= speed * delta
	if position.x < -get_viewport_rect().size.x / 2: # Adjust this value based on cloud size
		position.x = get_viewport_rect().size.x * 1.5 # Respawn far to the right
