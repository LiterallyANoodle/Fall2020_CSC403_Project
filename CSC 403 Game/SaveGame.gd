extends Resource
class_name SaveGame

const SAVE_GAME_PATH := "res://save/save_"

@export var player_position := Vector2.ZERO
@export var save_date: String

## Function to writing to and load from file
func write_savegame(id: String) -> void:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	ResourceSaver.save(self, save_path)
	
static func save_exists(id: String) -> bool:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.exists(save_path)
	
static func load_savegame(id: String) -> Resource:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.load(save_path, "", 2)
	

