extends State

class_name AirState

@export var ground_state: State
const DOUBLE_JUMP = 300

var has_doubled_jump = false

func state_process(_delta):
	if (character.is_on_floor()):
		next_state = ground_state

func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")&&!has_doubled_jump):
		double_jump()
		
func on_exit():
	if (next_state == ground_state):
		has_doubled_jump = false

func double_jump():
	character.velocity.y = -DOUBLE_JUMP
	has_doubled_jump = true
