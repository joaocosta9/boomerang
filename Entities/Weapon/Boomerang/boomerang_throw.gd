# In boomerang.gd
extends Area2D
@export var speed: float = 500.0
@export var rotation_speed: float = 60.0
@export var max_distance: float = 800.0

var direction = 1
var returning: bool = false

@export var max_range: float = 400
var start_position: Vector2 = Vector2.ZERO
var weapon = null

func _ready():
	start_position = position
		
func _process(delta):
	# Rotate the sprite
	rotation += rotation_speed * delta
	position.x += direction * speed * delta
	
	if position.x - start_position.x >= max_range:
		direction = -direction
		returning = true
		
	
	if returning and position.x - start_position.x <= 10:	
		weapon.boomerang_returned()  # Tell the weapon we're back
		queue_free()  # Remove the boomerang
