extends MarginContainer

var enemy_amount = 0
var parent

#var main = get_tree()
#var parent = main.get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	parent.transition("room1")
	self.queue_free()
	pass # Replace with function body.


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu_2.tscn")
	self.queue_free()
	pass # Replace with function body.
	
func player_position_getter():
	return $Player_Spawn.position
