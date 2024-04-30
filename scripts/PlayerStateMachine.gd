extends Node

class_name PlayerStateMachine

@export var character: CharacterBody2D
@export var current_state: State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			#Set the State up with what they need to funciton
			child.character = character
		else:
			push_warning("Child " + child.name + "Is not type of State of State Machine")

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func switch_states(new_state:State): 
	
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.on_enter()

func check_if_can_move():
	return current_state.can_move
	
func _input(event: InputEvent):
	current_state.state_input(event)
