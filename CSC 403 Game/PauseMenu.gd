extends Control

## Reference to the game manager
@export var game_manager : NewGame

# variable for the current room
var currentRoom
 
## Called when the node enters the scene tree for the first time
func _ready():
	
	hide()
	game_manager.connect("toggle_game_paused", _on_final_game_toggle_game_paused)
	$CenterContainer/VBoxContainer/Resume.grab_focus()
	

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Handler for the game manager's toggle_game_paused signal 
func _on_final_game_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

## Handler for the resume button pressed
func _on_resume_pressed():
	game_manager.game_paused = false
	$CenterContainer/VBoxContainer/Resume.grab_focus()

## Handler for the main menu button pressed
func _on_quit_pressed():
	get_tree().quit()

## Handler for the main menu button pressed
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu_2.tscn")
	self.queue_free()
	pass # Replace with function body.


func _on_save_pressed():
	var map = get_node("/root/NewGame/map-system")
	currentRoom = map.current_map
	

