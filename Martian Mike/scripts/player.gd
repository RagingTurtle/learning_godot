extends CharacterBody2D

@export var gravity = 400
@export var max_y_velocity = 500
@export var jump_force = 250
@export var speed = 125

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > max_y_velocity:
			velocity.y = max_y_velocity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_slide()
