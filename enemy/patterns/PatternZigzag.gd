extends PatternBase
class_name PatternZigzag

@export var move_speed: float = 40.0
@export var amplitude: float = 60.0
@export var frequency: float = 2.0
@export var bullet_speed: float = 200.0
@export var interval: float = 0.7
var timer: float = 0.0
var time: float = 0.0
var origin_x: float = 0.0

func setup(enemy: Node, params: Dictionary) -> void:
	timer = 0.0
	time = 0.0
	origin_x = enemy.position.x

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	time += delta
	enemy.position.y += move_speed * delta
	enemy.position.x = origin_x + sin(time * frequency) * amplitude
	timer -= delta
	if timer <= 0.0:
		timer = interval
		var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
		enemy.get_parent().add_child(b)
		b.fire(enemy.global_position, Vector2.DOWN, bullet_speed, 1)
