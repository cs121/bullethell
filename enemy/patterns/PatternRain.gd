extends PatternBase
class_name PatternRain

@export var bullet_speed: float = 300.0
@export var interval: float = 0.2
var timer: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	timer = 0.0

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	timer -= delta
	if timer <= 0.0:
		timer = interval
		var dir := Vector2.DOWN
		var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
		enemy.get_parent().add_child(b)
		b.fire(enemy.global_position, dir, bullet_speed, 1)
