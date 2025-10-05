extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var clouds_node: Node2D = $Clouds # Assuming you have a Node2D called "Clouds" in your Main.tscn
@onready var coin_label: Label = $UI/CoinLabel

var coins: int = 0

var CloudScene: PackedScene = preload("res://scenes/Cloud.tscn")
var time_since_last_cloud_spawn: float = 0.0
@export var cloud_spawn_interval: float = 3.0 # Seconds between cloud spawns
@export var max_clouds: int = 15

func _ready():
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("collected", _on_coin_collected)

	coin_label.text = "Coins: 0"

	# Generate some initial clouds across the screen
	for i in range(5):
		_spawn_cloud(randf_range(0, get_viewport_rect().size.x * 1.5) + camera.position.x)

func _physics_process(delta):
	# Make camera follow the player
	if player and camera:
		# Use delta for frame-rate independent movement
		var lerp_speed: float = 5.0  # units per second
		camera.position = camera.position.lerp(player.position, 1.0 - exp(-lerp_speed * delta))

func _process(delta):
	# Continuously spawn clouds
	time_since_last_cloud_spawn += delta
	if time_since_last_cloud_spawn >= cloud_spawn_interval:
		_spawn_cloud(camera.position.x + get_viewport_rect().size.x / 2 + 100) # Spawn to the right of the camera
		time_since_last_cloud_spawn = 0.0

func _spawn_cloud(spawn_x_position: float) -> void:
	if clouds_node.get_child_count() >= max_clouds:
		return
	var cloud = CloudScene.instantiate()
	clouds_node.add_child(cloud)

	# Randomize cloud position and speed
	cloud.position = Vector2(spawn_x_position, randf_range(-300, 500)) # Wider Y range for more randomness
	cloud.horizontal_speed = randf_range(20, 100) # Randomize horizontal speed
	cloud.move_speed = randf_range(5, 40) # Randomize vertical oscillation speed
	cloud.scale = Vector2(randf_range(0.5, 1.5), randf_range(0.4, 1.2)) # Randomize cloud size
	cloud.z_index = randi_range(-1, 0) # Randomize z-index between -1 and 0

func _on_coin_collected():
	coins += 1
	coin_label.text = "Coins: " + str(coins)
	print("Coin collected!")
