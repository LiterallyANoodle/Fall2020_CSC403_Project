extends Sprite2D
class_name Cursor

## Sprite that follows the mouse position.

func _physics_process(delta):
	self.global_position = get_global_mouse_position()
