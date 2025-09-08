extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

func _ready():
	print("Hello Godot 4!")
	var coin = $Platforms/MovingPlatform/Coin
	if coin:
		coin.connect("collected", _on_coin_collected)

func _process(_delta):
	# Make camera follow the player
	if player and camera:
		camera.position = player.position
		
func _on_coin_collected():
	print("Coin collected!")
