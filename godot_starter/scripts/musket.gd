extends Node3D
## Springfield-style musket: aim settle, hitscan with spread, long reload.

signal fired
signal reload_started
signal reload_finished
signal hit_target(body: Node, point: Vector3)

@export var settle_time: float = 2.0
@export var reload_time: float = 15.0
@export var max_spread_deg: float = 8.0
@export var min_spread_deg: float = 0.6
@export var damage: float = 55.0
@export var max_range: float = 180.0
@export var muzzle_path: NodePath ## optional Marker3D for FX origin

var loaded: bool = true
var aiming: bool = false
var settle: float = 0.0
var reloading: bool = false
var reload_progress: float = 0.0

@onready var _muzzle: Node3D = get_node_or_null(muzzle_path)


func _process(delta: float) -> void:
	if reloading:
		reload_progress += delta / reload_time
		if reload_progress >= 1.0:
			reload_progress = 1.0
			reloading = false
			loaded = true
			reload_finished.emit()
		return

	if aiming and loaded:
		settle = minf(settle + delta / settle_time, 1.0)
	else:
		settle = maxf(settle - delta / (settle_time * 0.5), 0.0)


func set_aiming(value: bool) -> void:
	aiming = value


func is_busy() -> bool:
	return reloading or aiming


func get_spread_rad() -> float:
	var t := settle
	var deg := lerpf(max_spread_deg, min_spread_deg, t)
	return deg_to_rad(deg)


func try_fire() -> void:
	if reloading or not loaded:
		return
	if not aiming:
		# Snap-fire allowed but very inaccurate (settle left as-is / near 0)
		pass
	loaded = false
	settle = 0.0
	_hitscan()
	fired.emit()
	# Auto-start reload after shot (milsim convenience; toggle if desired)
	try_reload()


func try_reload() -> void:
	if reloading or loaded:
		return
	reloading = true
	reload_progress = 0.0
	reload_started.emit()


func _hitscan() -> void:
	var cam := get_viewport().get_camera_3d()
	if cam == null:
		return
	var spread := get_spread_rad()
	var dir := -cam.global_transform.basis.z
	# Apply random cone
	var right := cam.global_transform.basis.x
	var up := cam.global_transform.basis.y
	var rx := randf_range(-spread, spread)
	var ry := randf_range(-spread, spread)
	dir = (dir + right * tan(rx) + up * tan(ry)).normalized()

	var from := cam.global_position
	var to := from + dir * max_range
	var space := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false
	query.collision_mask = 0xFFFFFFFF
	var result := space.intersect_ray(query)
	if result:
		var body: Node = result.collider
		hit_target.emit(body, result.position)
		if body and body.has_method("apply_damage"):
			body.apply_damage(damage, self)
