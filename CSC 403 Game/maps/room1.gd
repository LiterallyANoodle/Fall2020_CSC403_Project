extends TileMap

var enemy_amount = 1
var nextRoom = "room2"

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
	pass

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position
	
func player_position_getter():
	return $Player_Spawn.position
	
func door_collision(player_position):
	var collision = self.get_cell_tile_data(0, player_position)


func _on_area_2d_area_entered(area):
	parent.transition(self.nextRoom)
	get_node(^".").queue_free()
	pass # Replace with function body.
