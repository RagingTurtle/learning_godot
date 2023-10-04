extends Node2D

@export var next_level: PackedScene = null

@onready var start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone
@onready var timer_hud = $UILayer/HUD

var player = null

@export var level_time = 5

var timer_node = null
var time_left
var ONE_SECOND = 1

var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.move_to(start.get_spawn_pos())
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.trap_activated.connect(_on_trap_activated)
	
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	timer_hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = ONE_SECOND
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _on_level_timer_timeout():
	if !win:
		time_left -= ONE_SECOND
		timer_hud.set_time_label(time_left)
		print(time_left)
		if time_left < 0:
			reset_player()
			time_left = level_time
			timer_hud.set_time_label(time_left)


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body):
	reset_player()

func _on_trap_activated():
	reset_player()
	
func reset_player():
	player.move_to(start.get_spawn_pos())

func _on_exit_body_entered(body):
	if body is Player:
		exit.animate()
		player.active = false
		win = true
		await get_tree().create_timer(1.5).timeout
		if next_level != null:
			get_tree().change_scene_to_packed(next_level)
