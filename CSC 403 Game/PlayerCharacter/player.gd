extends CharacterBody2D
class_name Player

## Player class.
##
## Responsible for movement, health, and shooting.

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO
@onready var anim = $PlayerSprite/AnimationPlayer
@onready var sprite = $PlayerSprite

var player_health = 100
var enemy_attack_cooldown = true
var player_alive = true
var npc_in_range
var boss_in_range

func _process(delta):
	shoot_gun()

func _physics_process(delta):
	
	if npc_in_range == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "first")
			return
	
	if boss_in_range == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "second")
			return
	
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
		anim.play("idle")
		
	else:
		apply_movement(axis * ACCELERATION * delta)
		anim.play("walk")
		
	# handle look direction 
	if get_global_mouse_position().x > self.global_position.x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
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
	
	if player_health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	
		
func _on_regen_timeout():
	if player_health < 80:
		player_health = player_health + 10
		if player_health > 100:
			player_health = 100
	if player_health <= 0:
		player_health = 0

func player():
	pass

# if player detects either one of two, trigger the varible as true  (for dialogue system)
func _on_player_hitbox_body_entered(body):
	if body.has_method("npc"):
		npc_in_range = true
	
	if body.has_method("boss"):
		boss_in_range = true	
	
	
func timer_restart():
	$regen.start()

# if player detects either one of two, trigger the varible as false (for dialogue system)
func _on_player_hitbox_body_exited(body):
	if body.has_method("npc"):
		npc_in_range = false
	if body.has_method("boss"):
		boss_in_range = false	
