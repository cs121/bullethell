extends PatternBase
class_name PatternSine

@export var move_speed: float = 40.0
@export var amplitude: float = 80.0
@export var frequency: float = 3.0
@export var bullet_speed: float = 250.0
@export var interval: float = 1.0
var timer: float = 0.0
var time: float = 0.0
var origin_x: float = 0.0
var player: Player = null

func setup(enemy: Node, params: Dictionary) -> void:
	timer = 0.0
	time = 0.0
	origin_x = enemy.position.x
	player = enemy.get_tree().current_scene.get_node("Player") as Player

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	time += delta
	enemy.position.y += move_speed * delta
	enemy.position.x = origin_x + sin(time * frequency) * amplitude
	timer -= delta
	if timer <= 0.0 and player != null:
		timer = interval
		var dir := (player.global_position - enemy.global_position).normalized()
		var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
		enemy.get_parent().add_child(b)
		b.fire(enemy.global_position, dir, bullet_speed, 1)
