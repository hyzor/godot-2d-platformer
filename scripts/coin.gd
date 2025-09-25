extends Area2D

signal collected

func _ready():
	add_to_group("coins")
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		queue_free()