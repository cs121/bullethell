extends PatternBase
class_name PatternBurst

@export var interval: float = 1.5
@export var bullet_speed: float = 180.0
@export var count: int = 12
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
			var dir := Vector2.RIGHT.rotated(TAU * i / count)
			var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
			enemy.get_parent().add_child(b)
			b.fire(enemy.global_position, dir, bullet_speed, 1)
