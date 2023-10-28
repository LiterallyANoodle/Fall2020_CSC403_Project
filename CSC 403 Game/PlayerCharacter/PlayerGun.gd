extends AnimatedSprite2D
class_name PlayerGun

var bullets_scene = preload("res://PlayerCharacter/PlayerBullet.tscn")
@onready var aim_postition = null
@onready var self_position = null
@onready var anim = $AnimationPlayer

var bullets_instances = []
var last_shot = 0

@export var cooldown = 3
@export var time_to_live = 5000
@export var speed = 500

## Function instantiates a single bullet in the direction of aim.
func shoot_left(s, hardpoint = self):
	if last_shot < cooldown: return
	else: last_shot = 0
	
	var velocity = Vector2()
	var bullet = bullets_scene.instantiate()
	bullet.add_collision_exception_with(s)
	get_node("/root").add_child(bullet)
	
	var self_position = self.position
	var aim_position = get_parent().position 
	bullet.rotation = s.rotation
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
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
	
	
