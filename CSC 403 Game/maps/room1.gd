extends TileMap

var enemy_amount = 1
var nextRoom = "room2"
var entered = false

var npc = preload("res://NPC.tscn").instantiate()

var enemy_positions = {
	1 : "Enemy_Spawn1"
}
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	self.add_child(npc)
	npc.position = $npc1.position
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


func _on_area_2d_body_entered(body: PhysicsBody2D):
	entered = true

func _on_area_2d_body_exited(body):
	entered = false

func _on_r_1_doors_body_entered(body):
	if body == parent.player_instance:
		parent.transition(nextRoom)
