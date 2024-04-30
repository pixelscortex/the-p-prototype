extends State

class_name GroundState

const JUMP_VELOCITY = 300.0

@export var air_state: State

func state_input(event):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	character.velocity.y = -JUMP_VELOCITY
	next_state = air_state
