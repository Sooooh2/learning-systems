extends State
class_name ske_chase

# refrencing skeleton and player(right now null)
@export var skele: CharacterBody3D
var player: CharacterBody3D

# refrencing animation player 
@export var anim: AnimationPlayer
@export var run_speed := 7.0

# for movement
var target_dir: Vector3
var target_rotation: float

func enter():
	# assigns the variable player to the actual Player node formt he group "player" 
	player = get_tree().get_first_node_in_group("player")

	# chasing animation and put it on loop
	anim.play("Running_B")
	anim.get_animation("Running_B").loop = true

func exit():
	# resets the velocity to 0 when transitioned out of the chase state
	skele.velocity = Vector3.ZERO

func chase():
	# get direction to the player and setting the rotation accordingly 
	target_dir = (player.global_position - skele.global_position).normalized()

	# atan2 - converts the 2D direction (x, z) into a rotation angle in radians
	target_rotation = atan2(target_dir.x, target_dir.z)

func physics_update(delta: float):
	
	# continuously update direction and rotation toward player
	chase()
	
	# “Smoothly rotate the skeleton’s Y-axis rotation toward the angle that faces the player.”
	skele.rotation.y = lerp_angle(skele.rotation.y, target_rotation, delta * 5.0)

	# move skeleton forward in the direction of player with given run speed
	skele.velocity = target_dir * run_speed

	# transition back to idle state when player moves out of detection range
	if !skele.is_player_close:
		transitioned.emit(self, "ske_idle")

	skele.move_and_slide()
