extends PatternBase
class_name PatternCircle

@export var bullet_speed: float = 200.0
@export var count: int = 12
@export var interval: float = 1.0
var timer: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	# Reset timer whenever this pattern is activated
	timer = 0.0

func tick(enemy: Node, delta: float) -> void:
	# Emit a ring of bullets around the enemy at fixed intervals
	if not active:
		return
	timer -= delta
	if timer <= 0.0:
		timer = interval
		for i in count:
			var angle := TAU * (i / float(max(1, count)))
			var dir := Vector2.RIGHT.rotated(angle)
			var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
			enemy.get_parent().add_child(b)
			b.fire(enemy.global_position, dir, bullet_speed, 1)
