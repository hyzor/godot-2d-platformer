extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 2000.0
const FRICTION = 2000.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spawn_position = Vector2(576, 400)

func _ready():
	add_to_group("player")
	spawn_position = get_parent().get_node("SpawnPoint").position

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
	
	# Check if player fell off screen
	if position.y > 700:
		respawn()

func respawn():
	position = spawn_position
	velocity = Vector2.ZERO
