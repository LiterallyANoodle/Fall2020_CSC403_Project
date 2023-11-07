extends Node2D

# this scene is the base scene for all uses of the maps
# player and enemy spawns are handled here along with transitioning between maps


var current_map
## available maps is scalable for however many maps we want simply by adding to the dictionary
var available_maps = {
	"room1" : "res://maps/room1.tscn",
	"room2" : "res://maps/room2.tscn",
	"room3" : "res://maps/room3.tscn",
	"victory" : "res://death_screen.tscn"
}

var num_enemies
## enemy_array is used to keep track of enemy instances
var enemy_array = Array()
var enemy_spawn_location
var starting_map = "room1"
var player_spawn_location
## scene tree
var main
var player_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().current_scene
	transition(starting_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
## despawns enemies when health is 0, kills player if health is 0
func _process(delta):
	for id in enemy_array:
		if id.health == 0:
			id.queue_free()
			enemy_array.erase(id)
			num_enemies = num_enemies - 1
			if (num_enemies == 0):
				current_map.clear_doors()
			
			
	if player_instance.player_health == 0:
		var death_screen = load("res://death_screen.tscn").instantiate()
		main.add_child(death_screen)
		current_map.queue_free()
	# once all enemies in a room are killed, doors automatically open
	if (num_enemies == 0):
		current_map.clear_doors()
#	if Input.is_action_just_pressed("open_doors"):
#		for id in enemy_array:
#			id.queue_free()
#			enemy_array.erase(id)
#		current_map.clear_doors()

## Transition is a function to despawn the current room and all enemy and player instances and spawn in the next room
func transition(nextRoom):
	if current_map != null:
		current_map.queue_free()
		player_instance.queue_free()
	self.current_map = load(available_maps[nextRoom]).instantiate()
	main = get_tree().current_scene
	self.add_child(current_map) 
	player_instance = preload("res://PlayerCharacter/Player.tscn").instantiate()
	player_spawn_location = current_map.player_position_getter()
	player_instance.position = player_spawn_location
	main.add_child(player_instance)
	spawn_enemies()

## Transition_current is the same as transition, except it re-initiates the current room
func transition_current():
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(available_maps[self.current_map]).instantiate()
	main = get_tree().current_scene
	main.add_child(current_map) 
	
## Spawn_enemies spawns in enemies based on the current room configuration and places them in the enemy array
func spawn_enemies():
	num_enemies = current_map.enemy_amount
	for id in current_map.enemy_amount:
		var enemy_instance = load("res://enemy.tscn").instantiate()
		# id+1 because indexing starts at 1 for map dictionaries
		enemy_spawn_location = current_map.enemy_position_getter(id+1)
		enemy_instance.start(enemy_spawn_location, id)
		main.add_child(enemy_instance)
		enemy_array.append(enemy_instance)
	
