# acts like a template for all the states with class_name State 
# so new states should extend State
extends Node
class_name State

# emitted when a state wants to transition to another state
signal transitioned

# called when the state is entered
func enter():
	pass
	
# called when the state is exited
func exit():
	pass

# called every frame (non-physics)
func update(_delta: float):
	pass

# called every physics frame
func physics_update(_delta : float):
	pass 
