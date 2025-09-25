extends AnimatableBody2D

@export var speed: float = 80.0
@export var distance: float = 200.0
@export var horizontal: bool = true

var start_position
var direction: int = 1
var target_position

func _ready():
	start_position = position
	if horizontal:
		target_position = Vector2(start_position.x + distance, start_position.y)
	else:
		target_position = Vector2(start_position.x, start_position.y + distance)

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if horizontal:
		if direction > 0 and position.x >= target_position.x:
			direction = -1
		elif direction < 0 and position.x <= start_position.x:
			direction = 1
		
		velocity.x = speed * direction
	else:
		if direction > 0 and position.y >= target_position.y:
			direction = -1
		elif direction < 0 and position.y <= start_position.y:
			direction = 1
		
		velocity.y = speed * direction
	
	# Use move_and_collide with velocity * delta for proper movement
	move_and_collide(velocity * delta)
