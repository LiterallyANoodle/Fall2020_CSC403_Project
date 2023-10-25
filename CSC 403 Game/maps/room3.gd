extends TileMap

var enemy_amount = 3
var nextRoom = "room4"

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
	pass

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position

func player_position_getter():
	return $Player_Spawn.position
