extends PatternBase
class_name PatternFlower

@export var bullet_speed: float = 180.0
@export var count: int = 16
@export var interval: float = 0.6
@export var rotate_speed: float = 0.2
var timer: float = 0.0
var angle_offset: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	# Prepare timer and initial rotation offset
	timer = 0.0
	angle_offset = params.get("start_angle", 0.0)

func tick(enemy: Node, delta: float) -> void:
	# Fire rotating rings for a flower-like spread
	if not active:
		return
	timer -= delta
	angle_offset += rotate_speed * delta
	if timer <= 0.0:
		timer = interval
		for i in count:
			var angle := angle_offset + TAU * (i / float(max(1, count)))
			var dir := Vector2.RIGHT.rotated(angle)
			var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
			enemy.get_parent().add_child(b)
			b.fire(enemy.global_position, dir, bullet_speed, 1)
