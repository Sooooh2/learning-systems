extends State
class_name ske_idle

# refrencing skeleton 
@export var skele: CharacterBody3D

# refrencing animation player 
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"

# for movement
@export var walkSpeed := 6.0
@export var friction := 10.0
var move_dir: Vector3
var wander_time : float


func randomize_wander():
	var angle = randf_range(0, TAU)
	move_dir = Vector3(cos(angle), 0, sin(angle)).normalized()
	wander_time = randf_range(1, 3)



func enter():
	# idle walk animation and put it on loop
	anim.play("Walking_B")
	anim.get_animation("Walking_B").loop = true
	
	move_dir = Vector3.ZERO
	wander_time = 0.0
	# call the function right when the state starts
	randomize_wander()

func update(delta: float):
	# slowly blend (lerp) towards new random wander direction for smooth rotation
	move_dir = move_dir.lerp(Vector3(cos(randf_range(0,TAU)),0, sin(randf_range(0, TAU))),delta )

	# wander time ranges form 1 to 3, when the timer hits 0, side is switched
	if wander_time > 0:
		wander_time -= delta

	else: 
		randomize_wander()

	# rotate skeleton smoothly toward movement direction
	var target_rotation = atan2(move_dir.x, move_dir.z)
	skele.rotation.y = lerp_angle(skele.rotation.y, target_rotation, delta * 1.5)


func _physics_process(delta: float) -> void:
	# if no skeleton assigned, skip
	if !skele:
		return

	# calculate target velocity based on movement direction and walk speed
	var target_velocity = move_dir * walkSpeed

	# smoothly blend current velocity toward target (adds friction effect)
	skele.velocity = skele.velocity.lerp(target_velocity,delta * friction)

	# if player gets close, switch to chase state
	if skele.is_player_close:
		transitioned.emit(self,"ske_chase")
	
	skele.move_and_slide()
	
	
