extends State
class_name ske_idle

# refrencing skeleton 
@export var skele: CharacterBody3D

# for movement
@export var walkSpeed := 1.0
@export var friction := 20.0

var move_dir: Vector3
var wander_time : float


func randomize_wander():
	# skeleton pacing back and forth in x axis
	move_dir = Vector3(randf_range(-1,1),0,0).normalized()
	
	# random time to swtich directions (left, right)
	wander_time = randf_range(1,3)


func enter():
	# call the function right when the state starts
	randomize_wander()

func update(delta: float):
	# wander time ranges form 1 to 3, when the timer hits 0, side is switched
	if wander_time > 0:
		wander_time -= delta
	
	else: 
		randomize_wander()
	
	# lerp - linear interpolation - smooth blend b/w values
	# 
	move_dir = move_dir.lerp(Vector3(cos(randf_range(0,TAU)),0, sin(randf_range(0, TAU))),delta * 0.5)

func _physics_process(delta: float) -> void:
	if !skele:
		return
	var target_velocity = move_dir * walkSpeed
	skele.velocity = skele.velocity.lerp(target_velocity,delta * friction)
	
	skele.move_and_slide()
	
	
