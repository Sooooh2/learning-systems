extends CharacterBody3D

# animation and state machine
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $"State Machine"

# skeleton movement
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_player_close = false

# chase state starts
func _on_chase_box_body_entered(body: Node3D) -> void:
	# checks if the body entering the chase area is player or not
	if body.is_in_group("player"):
		print("player entered")
		
		# play run animation
		anim.play("Running_C")
		anim.get_animation("Running_C").loop = true
		
		# update state
		is_player_close = true
		state_machine.curr_state.transitioned.emit(self, "ske_chase")

# chase state ends
func _on_chase_finish_body_exited(body: Node3D) -> void:
	# checks if the body exited the chase area is player or not
	if body.is_in_group("player"):
		print("player exited")
		
		# play walk animation 
		anim.play("Walking_B")
		anim.get_animation("Walking_B").loop = true
		
		# update state
		is_player_close = false
		state_machine.curr_state.transitioned.emit(self, "ske_idle")
