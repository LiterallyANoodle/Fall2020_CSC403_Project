extends Node2D

var current_map
# available maps is scalable for however many maps we want
var available_maps = {
	"room1" : "res://maps/room1.tscn",
	"room2" : "res://maps/room2.tscn",
	"room3" : "res://maps/room3.tscn"
}


var door_key
var num_enemies
var enemy_array
var enemy_spawn_location
var starting_map = "room1"
var current_map_gd
var player_spawn_location

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_tree().current_scene
	transition(starting_map)
	var player_instance = load("res://player.tscn").instantiate()
	player_spawn_location = current_map.player_position_getter()
	player_instance.position = player_spawn_location
	main.add_child(player_instance)
	door_key = false
	for id in current_map.enemy_amount:
		var enemy_instance = load("res://enemy.tscn").instantiate()
		enemy_spawn_location = current_map.enemy_position_getter(id+1)
		enemy_instance.start(enemy_spawn_location, id)
		main.add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (door_key == true):
		current_map.clear_doors()
	if (num_enemies == 0):
		door_key = true
#	player collision must be added here for transition to next room
#	each room has a string nextRoom
#	transition(available_maps[current_room.nextRoom])

func enemy_killed():
	num_enemies -= 1

# map instantiated at z = -1 to be under the player
func transition(nextRoom):
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(available_maps[nextRoom]).instantiate()
	var main = get_tree().current_scene
#	self.current_map_gd = load(available_maps[nextRoom_gd])
	main.add_child(current_map) 
	
