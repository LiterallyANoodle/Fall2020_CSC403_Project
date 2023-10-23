extends ProgressBar


var maxHealth : int = 100
var currentHealth : int = maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value = maxHealth
	$TextureProgress.value = currentHealth
	
func takeDamage(damage: int):
	currentHealth -= damage
	if currentHealth < 0:
		currentHealth = 0
	
	# Update the currentHealth bar
	$TextureProgress.value = currentHealth

func heal(amount: int):
	# Increase the currentHealth
	currentHealth += amount
	if currentHealth > maxHealth:
		currentHealth = maxHealth
	
	# Update the currentHealth bar
	$TextureProgress.value = currentHealth

func update_health():
	var healthbar = $healthbar
	healthbar.value = healthbar
	
	if currentHealth >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func _on_regin_timer_timeout():
	if currentHealth < 100:
		currentHealth = currentHealth + 20
		if currentHealth > 100:
			currentHealth = 100
	if currentHealth <= 0:
		currentHealth = 0
		

'''
'this is for enemy' 
# In your enemy's script
extends Node

var player_health_bar : NodePath

func _ready():
	player_health_bar = $PathToPlayerHealthBar

func enemyAttack(damage: int):
	var health_bar = get_node(player_health_bar)
	if health_bar:
		health_bar.takeDamage(damage)
'''
		
