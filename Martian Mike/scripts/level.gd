extends Node2D

@onready var start_position = $StartPosition
@onready var player = $Player

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(body):
	reset_player()

func _on_trap_activated():
	reset_player()
	
func reset_player():
	player.move_to(start_position.global_position)
