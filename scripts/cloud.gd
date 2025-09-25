extends Node2D

@export var min_y: float = 0.0
@export var max_y: float = 200.0
@export var move_speed: float = 1.0

var direction: int = 1 # 1 for down, -1 for up
@export var horizontal_speed: float = 50.0 # Renamed for clarity

func _ready():
	min_y = position.y - 150 # Increased range for more oscillation
	max_y = position.y + 150  # Increased range for more oscillation

func _process(delta):
	# Horizontal movement
	position.x -= horizontal_speed * delta
	if position.x < -get_viewport_rect().size.x / 2: # Off screen, remove instead of respawn
		queue_free()

	# Vertical movement
	position.y += direction * move_speed * delta
	if position.y >= max_y:
		direction = -1
	elif position.y <= min_y:
		direction = 1
