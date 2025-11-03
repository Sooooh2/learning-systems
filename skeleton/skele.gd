extends CharacterBody3D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $"State Machine"

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_player_close = false


#func _ready() -> void:
	#anim.play("Walking_B")
	## to loop animation
	#anim.get_animation("Walking_B").loop = true
#
#
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	#move_and_slide()


func _on_chase_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("player entered")
		anim.play("Running_C")
		anim.get_animation("Running_C").loop = true
		is_player_close = true
		state_machine.curr_state.transitioned.emit(self, "ske_chase")



func _on_chase_box_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		anim.play("Walking_B")
		anim.get_animation("Walking_B").loop = true
		print("player exited")
		is_player_close = false
		state_machine.curr_state.transitioned.emit(self, "ske_idle")


func _on_chase_finish_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		anim.play("Walking_B")
		anim.get_animation("Walking_B").loop = true
		print("player exited")
		is_player_close = false
		state_machine.curr_state.transitioned.emit(self, "ske_idle")
