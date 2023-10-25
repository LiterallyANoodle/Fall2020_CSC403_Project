extends Node2D

# this scene is the base scene for all uses of the maps
# player and enemy spawns are handled here along with transitioning between maps


var current_map
# available maps is scalable for however many maps we want
var available_maps = {
	"room1" : "res://maps/room1.tscn",
	"room2" : "res://maps/room2.tscn",
	"room3" : "res://maps/room3.tscn"
}


var door_key
var num_enemies
var enemy_array = Array()
var enemy_spawn_location
var starting_map = "room3"
var current_map_gd
var player_spawn_location
var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().current_scene
	transition(starting_map)
	var player_instance = load("res://player.tscn").instantiate()
	player_spawn_location = current_map.player_position_getter()
	player_instance.position = player_spawn_location
	main.add_child(player_instance)
	door_key = false
	for id in current_map.enemy_amount:
		var enemy_instance = load("res://enemy.tscn").instantiate()
		# id+1 because indexing starts at 1 for map dictionaries
		enemy_spawn_location = current_map.enemy_position_getter(id+1)
		enemy_instance.start(enemy_spawn_location, id)
		main.add_child(enemy_instance)
		enemy_array.append(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for id in enemy_array:
		if id.health == 0:
			id.queue_free()
			enemy_array.erase(id)
			num_enemies -= 1
	# once all enemies in a room are killed, doors automatically open
	if (num_enemies == 0):
		current_map.clear_doors()
#	player collision must be added here for transition to next room
#	each room has a string nextRoom
#	transition(available_maps[current_room.nextRoom])


func transition(nextRoom):
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(available_maps[nextRoom]).instantiate()
	main = get_tree().current_scene
	main.add_child(current_map) 
	
