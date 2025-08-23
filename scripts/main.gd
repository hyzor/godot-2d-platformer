extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

func _ready():
	print("Hello Godot 4!")

func _process(_delta):
	# Make camera follow the player
	if player and camera:
		camera.position = player.position
