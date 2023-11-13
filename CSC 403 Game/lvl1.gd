extends Node

@export var game_manager : NewGame 

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_file("res://map-system.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
