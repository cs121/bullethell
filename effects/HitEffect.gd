extends Node2D
class_name HitEffect

@export var duration: float = 0.2
var pool: ObjectPool

@onready var timer: Timer = $Timer

func activate(pos: Vector2, pool_ref: ObjectPool) -> void:
	position = pos
	pool = pool_ref
	visible = true
	timer.start(duration)

func _on_timer_timeout() -> void:
	visible = false
	if is_instance_valid(pool):
		pool.release_instance(self)
