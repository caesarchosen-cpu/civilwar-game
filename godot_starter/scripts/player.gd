extends CharacterBody3D
## First-person Civil War soldier controller.
## Attach to a CharacterBody3D with a Camera3D child named "Camera3D"
## and a CollisionShape3D. Child a Node with musket.gd for the weapon.

const SPEED := 4.2
const SPRINT_MULT := 1.35
const JUMP_VELOCITY := 3.6
const MOUSE_SENS := 0.0025
const GRAVITY := 9.8

@onready var camera: Camera3D = $Camera3D

var pitch: float = 0.0
var musket: Node = null


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if has_node("Camera3D/Musket"):
		musket = $Camera3D/Musket


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENS)
		pitch = clamp(pitch - event.relative.y * MOUSE_SENS, deg_to_rad(-85.0), deg_to_rad(85.0))
		camera.rotation.x = pitch
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = (
			Input.MOUSE_MODE_VISIBLE
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
			else Input.MOUSE_MODE_CAPTURED
		)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	var speed := SPEED
	if Input.is_key_pressed(KEY_SHIFT):
		speed *= SPRINT_MULT
	# Slow while aiming or reloading
	if musket and musket.has_method("is_busy") and musket.is_busy():
		speed *= 0.55

	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()

	if musket:
		if Input.is_action_pressed("aim"):
			musket.set_aiming(true)
		else:
			musket.set_aiming(false)
		if Input.is_action_just_pressed("fire"):
			musket.try_fire()
		if Input.is_action_just_pressed("reload"):
			musket.try_reload()
