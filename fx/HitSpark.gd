extends Node2D
class_name HitSpark

@export var duration: float = 0.3
var time: float = 0.0

func show_at(pos: Vector2) -> void:
	position = pos
	time = duration
	Utils.activate(self)

func _process(delta: float) -> void:
	if time <= 0.0:
		return
	time -= delta
	if time <= 0.0:
		PoolManager.return_to_pool(self)
