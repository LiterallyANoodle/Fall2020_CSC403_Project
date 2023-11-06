extends Control

@export var game_manager : FinalGame
@onready var menu = $MarginContainer/VBoxContainer
@onready var options = $options
@onready var video = $videoControl
@onready var audio = $Audio
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
	get_tree().change_scene_to_file("res://final_game.tscn")


func show_and_hide(first, second):
	first.show()
	second.hide()

func _on_options_pressed():
	show_and_hide(options, menu)
	$options/VBoxContainer/Video.grab_focus()


func _on_quit_pressed():
	get_tree().quit()


func _on_video_pressed():
	show_and_hide(video, options)


func _on_audio_pressed():
	show_and_hide(audio, options)
	

func _on_back_pressed():
	show_and_hide(menu, options)
	$MarginContainer/VBoxContainer/Label/VBoxContainer/Start.grab_focus()



func _on_backfromvideo_pressed():
	show_and_hide(options, video)
	$options/VBoxContainer/Video.grab_focus()
	

func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$options/VBoxContainer/Video.grab_focus()


func _on_full_screen_toggled(button_pressed):
	if(button_pressed):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN, 3)



func _on_borderless_toggled(button_pressed):
	pass # Replace with function body.


func _on_v_sync_toggled(button_pressed):
	if(button_pressed):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_master_value_changed(value):
	volume(0, value)
	

func _on_music_value_changed(value):
	volume(1, value)
	
	
func _on_sound_fx_value_changed(value):
	volume(2, value)
