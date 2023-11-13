extends Node

## Custon class for the main game, named NewGame
class_name NewGame

# Signal emitted when the game is toggled between paused and unpaused states
signal toggle_game_paused(is_paused : bool)

# Reference to the map system scene, of type PackedScene
var map = preload("res://map-system.tscn")

# Reference to the map system scene, of type PackedScene
var spawn

# Variable to track the game paused state
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		# Set the game paused state, pause/unpause the tree, and emit the signal
		game_paused = value
		get_tree().paused = !game_paused
		emit_signal("toggle_game_paused", game_paused)

# Input handling for the game, toggles pause on 'ui_cancel' input
func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		game_paused = !game_paused
		

# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate the map system and add it as a child of the main game
	spawn = map.instantiate()
	add_child(spawn)
