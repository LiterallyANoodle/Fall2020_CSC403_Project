extends Node

class_name FinalGame
signal toggle_game_paused(is_paused : bool)

var map = preload("res://map-system.tscn")
var spawn

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = !game_paused
		emit_signal("toggle_game_paused", game_paused)


func _input(event: InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		game_paused =! game_paused

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn = map.instantiate()
	add_child(spawn)

