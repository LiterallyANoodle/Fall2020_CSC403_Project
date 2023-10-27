extends AnimatedSprite2D
class_name PlayerGun

var bullets_scene = preload("res://PlayerCharacter/PlayerBullet.tscn")
@onready var aim_postition = null
@onready var self_position = null

var bullets_instances: Array
var last_shot = 0

@export var cooldown = 10
@export var time_to_live = 5000
@export var speed = 1000

## Function instantiates a single bullet in the direction of aim.
func shoot_left(s, hardpoint = self):
	if last_shot < cooldown: return
	else: last_shot = 0
	
	var velocity = Vector2()
	var bullet = bullets_scene.instance()
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
		
