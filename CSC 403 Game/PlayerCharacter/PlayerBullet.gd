extends PhysicsBody2D
class_name PlayerBullet

var damage = 2

func player_bullet(target):
	target.health = target.health - self.damage
