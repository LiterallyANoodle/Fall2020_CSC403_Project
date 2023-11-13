extends Sprite2D
#class_name PlayerGun

## Controls the gun sprite connected to the player and instances bullets.
##
## Keeps track of bullets, shot cooldowns, and self animation. Bullets are stored in an array. 
## Each bullet is a dictionary with the bullet instance, velocity, and ticks since creation.
## PlayerGun animates itself using an AnimationPlayer which changes the selected frames in the sprite.
## PlayerGun also will flip itself vertically when facing the opposite side so that it is always visually upright.

var bullets_scene = preload("res://PlayerCharacter/PlayerBullet.tscn")
@onready var aim_postition = null
@onready var self_position = null
@onready var anim = $AnimationPlayer
@onready var sound = $ShotSound

var bullets_instances = []
var last_shot = 0

@export var cooldown = 3
@export var time_to_live = 5000
@export var speed = 500

var parent

func _ready():
	parent = get_tree().current_scene

## Function instantiates a single bullet in the direction of aim. s is the parent KinematicBody2D and hardpoint is the instance of PlayerGun.
func shoot_left(s, hardpoint = self):
	if last_shot < cooldown: return
	else: last_shot = 0
	
	var velocity = Vector2()
	var bullet = bullets_scene.instantiate()
	bullet.add_collision_exception_with(s)
	get_node("/root").add_child(bullet)
	
	var self_position = self.position
	var aim_position = hardpoint.rotation
	bullet.rotation = hardpoint.rotation
	bullet.position = hardpoint.global_position
	
	velocity = Vector2(speed, 0).rotated(bullet.rotation)
	
	bullets_instances.append({
		"bullet": bullet, 
		"velocity": velocity,
		"ticks": 0
	})
	
	if anim.is_playing():
		anim.stop()
		anim.play("Shoot")
		anim.queue("Idle")
	else:
		anim.play("Shoot")
		anim.queue("Idle")
		
	if sound.playing:
		sound.stop()
		sound.play()
	else:
		sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# handle active bullet instances
	
	last_shot += 1
	
	for bullet in bullets_instances:
		
		var b = bullet["bullet"]
		if bullet["ticks"] == time_to_live:
			b.queue_free()
			bullets_instances.erase(bullet)
			pass
		
		var collision = b.move_and_collide(bullet["velocity"] * delta)
		
		if (collision):
			# var collider = collision.collider
			# if (collider.get_class() == "Enemy"):
			# 	collider.apply_damage(b.damage)
			b.queue_free()
			bullets_instances.erase(bullet)
			
		bullet["ticks"] += 1
		
	# change direction of aim.
	self.look_at(get_node("/root/NewGame/Player").position)
	# print(get_viewport().get_mouse_position())
	self.rotation_degrees = fmod(self.rotation_degrees + 360.0, 360.0)
	# print(fmod(self.rotation_degrees + 90, 360.0))
	if (fmod(self.rotation_degrees + 90, 360.0) > 180):
		self.flip_v = true
	else:
		self.flip_v = false
	
