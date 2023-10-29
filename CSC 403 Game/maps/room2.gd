extends TileMap

var entered 
var enemy_amount = 3
var nextRoom = "room3"

var enemy_positions = {
	1 : "Enemy_Spawn1",
	2 : "Enemy_Spawn2",
	3 : "Enemy_Spawn3"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://test_world_1.tscn")

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position
	
func player_position_getter():
	return $Player_Spawn.position




func _on_area_2d_body_entered(body):
	entered = true


func _on_area_2d_body_exited(body):
	entered = false
