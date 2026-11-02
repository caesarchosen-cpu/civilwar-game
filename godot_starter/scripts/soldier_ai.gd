extends CharacterBody3D
## Simple AI private: stay near formation slot, face enemy line, fire & reload.

enum Side { UNION, CSA }

@export var side: Side = Side.UNION
@export var max_hp: float = 100.0
@export var fire_interval: float = 16.0
@export var accuracy: float = 0.35 ## 0–1 chance to register a "hit event" at range

var hp: float = 100.0
var alive: bool = true
var slot_index: int = 0
var formation: Node = null
var reloading: bool = false
var reload_left: float = 0.0
var fire_cd: float = 0.0
var routed: bool = false

signal died(soldier: Node)
signal fired_shot(soldier: Node)


func _ready() -> void:
	hp = max_hp
	fire_cd = randf_range(0.0, fire_interval)


func _physics_process(delta: float) -> void:
	if not alive or routed:
		return

	# Hold formation slot
	if formation and formation.has_method("get_slot_transform"):
		var target: Transform3D = formation.get_slot_transform(slot_index)
		global_position = global_position.lerp(target.origin, clampf(4.0 * delta, 0.0, 1.0))
		var look_pos := global_position + (-target.basis.z) * 5.0
		look_pos.y = global_position.y
		look_at(look_pos, Vector3.UP)

	if reloading:
		reload_left -= delta
		if reload_left <= 0.0:
			reloading = false
		return

	fire_cd -= delta
	if fire_cd <= 0.0:
		_try_volleys_or_fire()
		fire_cd = fire_interval + randf_range(-2.0, 2.0)


func _try_volleys_or_fire() -> void:
	if formation and formation.has_method("is_volley_allowed"):
		if not formation.is_volley_allowed():
			return
	fired_shot.emit(self)
	reloading = true
	reload_left = 14.0 + randf_range(-1.0, 2.0)
	# Damage resolution can be handled by formation / battle manager


func apply_damage(amount: float, _source: Node = null) -> void:
	if not alive:
		return
	hp -= amount
	if hp <= 0.0:
		alive = false
		died.emit(self)
		# Ragdoll / hide mesh later
		visible = false
		collision_layer = 0


func rout() -> void:
	routed = true


func rally() -> void:
	if alive:
		routed = false
