extends PatternBase
class_name PatternSpiral

@export var bullet_speed: float = 300.0
@export var rate: float = 0.1
var angle: float = 0.0
var timer: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	angle = params.get("start_angle", 0.0)
	timer = 0.0

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	timer -= delta
	angle += delta * 3.0
	if timer <= 0.0:
		timer = rate
		var dir := Vector2.RIGHT.rotated(angle)
		var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
		enemy.get_parent().add_child(b)
		b.fire(enemy.global_position, dir, bullet_speed, 1)
