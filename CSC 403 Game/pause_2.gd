extends Control


@export var game_manager : Game2

# Called when the node enters the scene tree for the first time

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)
	$Panel/VBoxContainer/resumeGame.grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_resume_pressed():
	game_manager.game_paused = false


func _on_quit_pressed():
	get_tree().quit()


func _on_save_pressed():
	pass # Replace with function body.


func _on_settings_pressed():
	pass # Replace with function body.
