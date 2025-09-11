extends Node
class_name GameManager

var enemy_pool: ObjectPool
var projectile_pool: ObjectPool
var effect_pool: ObjectPool

func initialize(e_pool: ObjectPool, p_pool: ObjectPool, ef_pool: ObjectPool) -> void:
	enemy_pool = e_pool
	projectile_pool = p_pool
	effect_pool = ef_pool

func start_mission(path: String) -> void:
	var json_text := ""
	if FileAccess.file_exists(path):
		json_text = FileAccess.get_file_as_string(path)
	else:
		push_error("Mission file not found: %s" % path)
		return
	var result := JSON.parse_string(json_text)
	if typeof(result) != TYPE_DICTIONARY:
		push_error("Invalid mission data in %s" % path)
		return
	await _run_waves(result.get("waves", []))

func _run_waves(waves: Array) -> void:
	for wave in waves:
		var count: int = wave.get("count", 0)
		var interval: float = wave.get("spawn_interval", 1.0)
		for i in count:
			if not is_instance_valid(enemy_pool):
				return
			var enemy := enemy_pool.get_instance() as Node2D
			if enemy == null:
				break
			var spawn_pos := Vector2(randf_range(0.0, 640.0), -50.0)
			if enemy.has_method("activate"):
				enemy.activate(spawn_pos, enemy_pool)
			await get_tree().create_timer(interval).timeout

func spawn_hit_effect(pos: Vector2) -> void:
	if not is_instance_valid(effect_pool):
		return
	var effect := effect_pool.get_instance() as Node2D
	if effect == null:
		return
	if effect.has_method("activate"):
		effect.activate(pos, effect_pool)

func on_enemy_killed() -> void:
	# Placeholder for score handling or wave progress
	pass
