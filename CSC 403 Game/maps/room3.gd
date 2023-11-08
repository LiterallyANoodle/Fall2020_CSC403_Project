extends TileMap

var enemy_amount = 3
var nextRoom = "boss_arena"
var parent
var spikes


var enemy_positions = {
	1 : "Enemy_Spawn1",
	2 : "Enemy_Spawn2",
	3 : "Enemy_Spawn3"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	spikes = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spikes:
		parent.player_instance.player_health = parent.player_instance.player_health -10*delta
		parent.player_instance.timer_restart()
	pass

func clear_doors():
	clear_layer(1)
	
func enemy_position_getter(id):
	return get_node(enemy_positions[id]).position

func player_position_getter():
	return $Player_Spawn.position


func _on_area_2d_area_entered(area):
	parent.transition(nextRoom)
	pass # Replace with function body.


func _on_spikes_area_area_entered(area):
	spikes = true
	pass # Replace with function body.


func _on_spikes_area_area_exited(area):
	spikes = false
	pass # Replace with function body.
