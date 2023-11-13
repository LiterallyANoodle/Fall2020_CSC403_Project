extends Control

## FinalGame class used in the project 
@export var game_manager : FinalGame

## UI elements references
@onready var menu = $MarginContainer/VBoxContainer
@onready var options = $options
@onready var video = $videoControl
@onready var audio = $Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set focus on the start button for user interaction
	$MarginContainer/VBoxContainer/Label/VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Toggle menu visibility and pause game on 'ui_cancel' input
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
		

## Toggle menu visibility and pause game
func toggle():
	visible = !visible
	get_tree().paused = visible
	_ready()

## Start button pressed - initiate new game
func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://new_game.tscn")

## Show and hide different menu screens
func show_and_hide(first, second):
	first.show()
	second.hide()

## Options button pressed - switch to options menu
func _on_options_pressed():
	show_and_hide(options, menu)
	$options/VBoxContainer/Video.grab_focus()

## Quit button pressed - exit the game
func _on_quit_pressed():
	get_tree().quit()

## Video button pressed - switch to video options menu
func _on_video_pressed():
	show_and_hide(video, options)

## Audio button pressed - switch to audio options menu
func _on_audio_pressed():
	show_and_hide(audio, options)
	
## Back button pressed - return to the main menu
func _on_back_pressed():
	show_and_hide(menu, options)
	$MarginContainer/VBoxContainer/Label/VBoxContainer/Start.grab_focus()


## Back from video options button pressed - return to options menu
func _on_backfromvideo_pressed():
	show_and_hide(options, video)
	$options/VBoxContainer/Video.grab_focus()
	

## Back from audio options button pressed - return to options menu
func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$options/VBoxContainer/Video.grab_focus()

## Full screen toggle button pressed - adjust window size
func _on_full_screen_toggled(button_pressed):
	if(button_pressed==true):
		DisplayServer.window_set_size(Vector2i(1920,1080))
	else:
		DisplayServer.window_set_size(Vector2i(720,800))


## V-sync toggle button pressed - adjust V-sync mode
func _on_v_sync_toggled(button_pressed):
	if(button_pressed):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
## Adjust volume on specified audio bus		
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

## Adjust master volume based on the slider value, with mute option
func _on_master_value_changed(value):
	if(value == -45):
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
		volume(0, value)

