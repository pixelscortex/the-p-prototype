extends CharacterBody2D

const SPEED = 250.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite_2d = $Sprite2D
@onready var state_machine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle jump.
	#if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			#velocity.y = JUMP_VELOCITY
		#elif not has_double_jumped:
			#velocity.y = JUMP_VELOCITY * 0.85
			#has_double_jumped = true
		
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_facing_direction():
	if direction.x > 0:
		sprite_2d.flip_h = false
	elif direction.x < 0:
		sprite_2d.flip_h = true

func update_animation():
	animation_tree.set("parameters/Move/blend_position",direction.x)
	
