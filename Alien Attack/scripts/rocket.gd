extends Area2D

@export var rocket_speed = 5
@onready var onScreenNode = $OnScreenNotifier

func _ready():
    onScreenNode.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
    global_position.x += rocket_speed * delta

func _on_screen_exited():
    queue_free()