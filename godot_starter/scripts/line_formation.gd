extends Node3D
## Spawns / arranges soldiers into a 2-rank company line facing -Z of this node.

signal morale_changed(value: float)
signal routed
signal rallied
signal volley_ordered

@export var ranks: int = 2
@export var files: int = 10
@export var file_spacing: float = 1.1
@export var rank_spacing: float = 1.4
@export var soldier_scene: PackedScene
@export var side_union: bool = true
@export var auto_volley_interval: float = 18.0

var soldiers: Array = []
var morale: float = 100.0
var volley_hold: bool = true ## if true, AI waits for officer pulse
var _volley_pulse: bool = false
var _auto_timer: float = 0.0


func _ready() -> void:
	_spawn_line()
	_auto_timer = auto_volley_interval * 0.5


func _process(delta: float) -> void:
	_auto_timer -= delta
	if _auto_timer <= 0.0:
		_auto_timer = auto_volley_interval
		order_volley()
	_update_morale()


func _spawn_line() -> void:
	soldiers.clear()
	if soldier_scene == null:
		push_warning("line_formation: no soldier_scene assigned — slots only")
	var idx := 0
	for rank in ranks:
		for file in files:
			var x := (file - (files - 1) * 0.5) * file_spacing
			var z := rank * rank_spacing
			var xf := Transform3D(Basis.IDENTITY, Vector3(x, 0.0, z))
			if soldier_scene:
				var s: Node = soldier_scene.instantiate()
				add_child(s)
				s.transform = xf
				if s.has_method("set") or true:
					if "slot_index" in s:
						s.slot_index = idx
					if "formation" in s:
						s.formation = self
					if "side" in s:
						s.side = 0 if side_union else 1
				if s.has_signal("died"):
					s.died.connect(_on_soldier_died)
				soldiers.append(s)
			idx += 1


func get_slot_transform(slot_index: int) -> Transform3D:
	var rank := int(slot_index / files)
	var file := slot_index % files
	var x := (file - (files - 1) * 0.5) * file_spacing
	var z := rank * rank_spacing
	# World transform of slot
	return global_transform * Transform3D(Basis.IDENTITY, Vector3(x, 0.0, z))


func is_volley_allowed() -> bool:
	if not volley_hold:
		return true
	if _volley_pulse:
		_volley_pulse = false
		return true
	return false


func order_volley() -> void:
	_volley_pulse = true
	volley_ordered.emit()


func alive_count() -> int:
	var n := 0
	for s in soldiers:
		if is_instance_valid(s) and ("alive" in s) and s.alive and not (("routed" in s) and s.routed):
			n += 1
	return n


func _on_soldier_died(_s: Node) -> void:
	morale = maxf(0.0, morale - 4.0)
	morale_changed.emit(morale)


func _update_morale() -> void:
	var total := soldiers.size()
	if total == 0:
		return
	var alive := alive_count()
	var ratio := float(alive) / float(total)
	# Soft recovery
	if ratio > 0.6:
		morale = minf(100.0, morale + 0.01)
	if morale < 20.0 and ratio < 0.5:
		_rout_all()
	elif morale > 40.0:
		pass


func _rout_all() -> void:
	for s in soldiers:
		if is_instance_valid(s) and s.has_method("rout"):
			s.rout()
	routed.emit()


func rally_line() -> void:
	morale = minf(100.0, morale + 25.0)
	for s in soldiers:
		if is_instance_valid(s) and s.has_method("rally"):
			s.rally()
	rallied.emit()
	morale_changed.emit(morale)
