extends PatternBase
class_name PatternFan

@export var bullet_speed: float = 250.0
@export var count: int = 5
@export var spread: float = 0.5
@export var interval: float = 0.5
var timer: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	timer = 0.0

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	timer -= delta
	if timer <= 0.0:
		timer = interval
		for i in count:
			var t := -spread * 0.5 + i * (spread / max(1, count - 1))
			var dir := Vector2.DOWN.rotated(t)
			var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
			enemy.get_parent().add_child(b)
			b.fire(enemy.global_position, dir, bullet_speed, 1)
