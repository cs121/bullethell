extends Node
class_name Spawner

@export var waves: Array = [
	{"time": 1.0, "pattern": &"fan", "pos": Vector2(0, -100)},
	{"time": 3.0, "pattern": &"spiral", "pos": Vector2(100, -120)}
]

var timer: float = 0.0
var index: int = 0

func _process(delta: float) -> void:
	timer += delta
	while index < waves.size() and timer >= waves[index]["time"]:
		var w: Dictionary = waves[index]
		_spawn_enemy(w)
		index += 1

func _spawn_enemy(w: Dictionary) -> void:
	var enemy := PoolManager.get_from_pool(&"enemies") as Enemy
	get_parent().add_child(enemy)
	enemy.activate(w.get("pos", Vector2.ZERO), w.get("pattern", &"fan"), w.get("params", {}))
