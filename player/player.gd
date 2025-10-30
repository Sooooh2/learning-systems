extends CharacterBody3D

# cam
@onready var head: Node3D = $head
@onready var cam: Camera3D = $head/Camera3D

# player movement
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# mouse - cam movement
var mouse_sensitivity := 0.003


func _ready() -> void:
	# hide mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	# head - cam movement relative to x and y axis 
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		# clamping to limit movement in up and direction 
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(60))


func _unhandled_input(event: InputEvent) -> void:
	# to make the mouse cursor visible again
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# to hide the mouse cursor again 
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
