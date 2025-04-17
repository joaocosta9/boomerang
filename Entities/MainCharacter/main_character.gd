extends CharacterBody2D

# Constants
const SPEED = 400.0
const JUMP_VELOCITY = -400.0

# Node references
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

# Character state
var isLeft = false
var weapon

func _ready():
	weapon = BoomerangWeapon.new(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jump"
	
	handle_movement()
	handle_jump()
	handle_attack()
	move_and_slide()
	update_animations()

func handle_movement() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		isLeft = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func handle_attack() -> void:
	if Input.is_action_just_pressed("attack"):
		weapon.attack()

func update_animations() -> void:
	sprite_2d.flip_h = isLeft
	
	if not is_on_floor():
		sprite_2d.animation = "jump"
	elif velocity.x != 0:
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "default"
