extends Node

# initial and current states
# set initial state in the inspector 
@export var init_state : State
var curr_state: State

# dictionary to keep track of different states - key = state name, value = state instance
var states : Dictionary = {}


func _ready() -> void:
	# append the current state in the dictionary  and connect signal to transition 
	# also lower all the characters to prevent future errors
	for child in get_children():
		if child is State: 
			states[child.name.to_lower()] = child 
			child.transitioned.connect(on_child_transition)
			
	
	# set and enter the initial state if one is assigned
	if init_state:
		init_state.enter()
		curr_state = init_state


func _process(delta: float) -> void:
	# if it is current state and keep calling update function 
	if curr_state:
		curr_state.update(delta)


func _physics_process(delta: float) -> void:
	# if it is current state and keep calling physics update function 
	if curr_state:
		curr_state.physics_update(delta)


func on_child_transition(state, new_state_name):
	# continue if it is not current state
	if state != curr_state:
		return
	
	# find appropriate state from states dictionary to transition to 
	# give the value to the variable new state
	var new_state = states.get(new_state_name.to_lower())
	
	# debug
	print("Transitioning from %s to %s" % [curr_state.name, new_state_name])

	# continue if no new state found
	if !new_state:
		return
	
	# if it is still current state then exit it 
	if curr_state:
		curr_state.exit()
	
	# enter the new state and make it the current state 
	new_state.enter()
	curr_state = new_state
