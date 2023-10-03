extends Node2D

signal trap_activated

func _on_area_2d_body_entered(body):
	if body is Player:
		trap_activated.emit()
