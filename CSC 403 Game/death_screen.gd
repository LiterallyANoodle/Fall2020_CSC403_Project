extends MarginContainer

#var main = get_tree().current_scene
#var parent = main.get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
#	parent.transition_current()
	self.queue_free()
	pass # Replace with function body.


func _on_main_menu_pressed():
	# go to main menu
	self.queue_free()
	pass # Replace with function body.
