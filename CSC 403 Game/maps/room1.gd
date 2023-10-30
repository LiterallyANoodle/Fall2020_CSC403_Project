extends TileMap

var enemy_amount = 1
var nextRoom = "room2"
var entered = false

var enemy_positions = {
	1 : "Enemy_Spawn1"
}
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://test_world_2.tscn")

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position
	
func player_position_getter():
	return $Player_Spawn.position
<<<<<<< Updated upstream


func _on_area_2d_body_entered(body: PhysicsBody2D):
	entered = true


func _on_area_2d_body_exited(body):
	entered = false

=======
	
>>>>>>> Stashed changes
func door_collision(player_position):
	var collision = self.get_cell_tile_data(0, player_position)


func _on_area_2d_area_entered(area):
<<<<<<< Updated upstream
	#parent.transition(self.nextRoom)
	#get_node(^".").queue_free()
=======
	parent.transition(self.nextRoom)
	get_node(^".").queue_free()
>>>>>>> Stashed changes
	pass # Replace with function body.
