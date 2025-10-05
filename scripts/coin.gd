extends Area2D

signal collected

var time: float = 0.0

func _ready():
	add_to_group("coins")
	connect("body_entered", _on_body_entered)

func _process(delta):
	time += delta
	scale.x = abs(sin(time * 5.0))

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		queue_free()
