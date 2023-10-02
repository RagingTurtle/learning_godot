extends Area2D

signal died

@export var enemy_speed = 5

func _physics_process(delta):
	global_position.x -= enemy_speed * delta

func die():
	emit_signal("died")
	queue_free()

func _on_body_entered(body):
	body.take_damage()
	die()
