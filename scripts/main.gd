extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var clouds_node: Node2D = $Clouds # Assuming you have a Node2D called "Clouds" in your Main.tscn

var CloudScene: PackedScene = preload("res://scenes/Cloud.tscn")
var time_since_last_cloud_spawn: float = 0.0
@export var cloud_spawn_interval: float = 3.0 # Seconds between cloud spawns

func _ready():
	var coin: Area2D = $Platforms/MovingPlatform/Coin
	if coin:
		coin.connect("collected", _on_coin_collected)

	# Generate some initial clouds across the screen
	for i in range(7):
		_spawn_cloud(randf_range(0, get_viewport_rect().size.x * 1.5) + camera.position.x)

func _process(delta):
	# Make camera follow the player
	if player and camera:
		camera.position = player.position

	# Continuously spawn clouds
	time_since_last_cloud_spawn += delta
	if time_since_last_cloud_spawn >= cloud_spawn_interval:
		_spawn_cloud(camera.position.x + get_viewport_rect().size.x / 2 + 100) # Spawn to the right of the camera
		time_since_last_cloud_spawn = 0.0

func _spawn_cloud(spawn_x_position: float):
	var cloud = CloudScene.instantiate()
	clouds_node.add_child(cloud)
	
	# Randomize cloud position and speed
	cloud.position = Vector2(spawn_x_position, randf_range(-100, 300)) # Adjust Y range as needed
	cloud.horizontal_speed = randf_range(20, 80) # Randomize horizontal speed
	cloud.move_speed = randf_range(5, 15) # Randomize vertical oscillation speed
	cloud.scale = Vector2(randf_range(0.6, 1.4), randf_range(0.9, 1.1)) # Randomize cloud size
	cloud.z_index = randi_range(-1, 1) # Randomize z-index between -1 and 1

func _on_coin_collected():
	print("Coin collected!")
