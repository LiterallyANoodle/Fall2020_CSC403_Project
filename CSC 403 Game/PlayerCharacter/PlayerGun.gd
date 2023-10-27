extends AnimatedSprite2D
class_name PlayerGun

@onready var bullets_scene = preload("res://PlayerCharacter/PlayerBullet.tscn")
var  bullets_instances: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (Input.is_action_just_pressed("player_shoot_left")):
		bullets_scene.instantiate()
		
