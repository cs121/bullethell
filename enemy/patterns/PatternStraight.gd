extends PatternBase
class_name PatternStraight

@export var move_speed: float = 40.0
@export var bullet_speed: float = 220.0
@export var interval: float = 0.6
var timer: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	# Reset shoot timer on activation
	timer = 0.0

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	# Simple downward movement
	enemy.position.y += move_speed * delta
	# Fire straight down at intervals
	timer -= delta
	if timer <= 0.0:
		timer = interval
		var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
		enemy.get_parent().add_child(b)
		b.fire(enemy.global_position, Vector2.DOWN, bullet_speed, 1)
