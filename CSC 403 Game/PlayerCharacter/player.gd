extends CharacterBody2D
class_name Player

## Player class.
##
## Responsible for movement, health, and shooting.

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO

var player_health = 10

func _process(delta):
	shoot_gun()

func _physics_process(delta):
	move(delta)
	update_health()
	
## Detects a left click and fires the gun.
func shoot_gun():
	if Input.is_action_just_pressed("player_shoot_left"):
		var gun = get_node_or_null("Gun")
		if gun: gun.shoot_left(self.get_node("."))
	
## Determines the direction of movement based on input.
func get_input_axis():
	axis.x = int(Input.is_action_pressed("player_move_right")) - int(Input.is_action_pressed("player_move_left"))
	axis.y = int(Input.is_action_pressed("player_move_down")) - int(Input.is_action_pressed("player_move_up"))
	return axis.normalized()

## Moves the player.
func move(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
		
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
		
	else:
		velocity = Vector2.ZERO
		
func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.limit_length(MAX_SPEED)
	
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = player_health


func _on_regen_timeout():
	if player_health < 100:
		player_health = player_health + 10
		if player_health > 100:
			player_health = 100
	if player_health <= 0:
		player_health = 0
