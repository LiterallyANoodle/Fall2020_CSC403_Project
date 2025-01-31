extends Control

@onready var worlds: Array = [$worldIcon, $worldIcon2, $worldIcon3, $worldIcon4, $worldIcon5]
var current_world: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$playerIcon.global_position = worlds[current_world].global_position


func _input(event):
	if event.is_action_pressed("ui_left") and current_world > 0:
		current_world -= 1
		$PlayerIcon.global_position = worlds[current_world].global_position
	
	if event.is_action_pressed("ui_right") and current_world < worlds.size() - 1:
		current_world += 1
		$playerIcon.global_position = worlds[current_world].global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
