extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var max_y_velocity = 500
@export var jump_force = 250
@export var speed = 125

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > max_y_velocity:
			velocity.y = max_y_velocity
	
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump(jump_force)
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
		
	velocity.x = direction * speed
	move_and_slide()
	
	update_animations(direction)
	
func jump(force):
			velocity.y = -force

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

func move_to(new_position):
	velocity = Vector2.ZERO
	global_position = new_position
