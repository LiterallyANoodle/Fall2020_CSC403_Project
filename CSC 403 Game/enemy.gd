extends Sprite2D

@export var speed = 400
var screen_size
var enemy_id
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	self.health = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO
	self.position = position.clamp(Vector2.ZERO, screen_size)


func start(pos, given_id):
	self.position = pos
	self.enemy_id = given_id
