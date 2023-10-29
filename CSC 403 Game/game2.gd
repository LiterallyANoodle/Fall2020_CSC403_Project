extends Node

class_name Game2
signal toggle_game_paused(is_paused : bool)

var map = load("res://map-system.tscn")
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = !game_paused
		emit_signal("toggle_game_paused", game_paused)
var spawn
func _input(event: InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		game_paused =! game_paused
		
# Called when the node enters the scene tree for the first time.

func _ready():
	spawn = map.instantiate()
	add_child(spawn)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 
