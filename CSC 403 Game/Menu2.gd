extends Control

@export var game_manager : GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Label/VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
		

func toggle():
	visible = !visible
	get_tree().paused = visible
	_ready()


func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_options_pressed():
	pass # Replace with function body.



func _on_back_pressed():
	pass # Replace with function body.
