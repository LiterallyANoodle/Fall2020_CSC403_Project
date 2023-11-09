extends CharacterBody2D
#class_name Enemy

@export var speed = 400
var screen_size
var enemy_id
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	self.health = 20
	
	
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
	if body.has_method("PlayerBullet"):
		health -= 2
		print("player attacked")
