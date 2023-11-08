extends TileMap

var enemy_amount = 1
var nextRoom = "victory"
var parent
var spikes


var enemy_positions = {
	1 : "BossSpawn",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	spikes = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spikes:
		parent.player_instance.player_health = parent.player_instance.player_health -5*delta
	pass

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position

func player_position_getter():
	return $Player_Spawn.position

