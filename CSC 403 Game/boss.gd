extends CharacterBody2D
#class_name Enemy

var gun = preload("res://BossGun.tscn").instantiate()
var gun2 = preload("res://BossGun.tscn").instantiate()

var gun_array = Array()

@export var speed = 400
var screen_size
var enemy_id
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	self.health = 20
	self.add_child(gun)
	self.add_child(gun2)
	gun_array.append(gun)
	gun_array.append(gun2)
	gun2.set_rot(120)
	
	
func _physics_process(delta):
	update_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	self.position = position.clamp(Vector2.ZERO, screen_size)

func start(pos, given_id):
	self.position = pos
	self.enemy_id = given_id
	
func update_health():
	var healthbar = $boss_health
	healthbar.value = health

func _on_enemy_hitbox_body_entered(body):
	if body is PlayerBullet:
		print("player attacked")
		body.player_bullet(self)
		$HitSound.stop()
		$HitSound.play()

func _on_timer_timeout():
	for item in gun_array:
		item.shoot_left(self.get_node("."))
	pass # Replace with function body.
	
func boss():
	pass

