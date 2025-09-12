extends PatternBase
class_name PatternChase

@export var move_speed: float = 70.0
@export var interval: float = 0.8
@export var bullet_speed: float = 260.0
var timer: float = 0.0
var player: Player = null

func setup(enemy: Node, params: Dictionary) -> void:
	timer = 0.0
	player = enemy.get_tree().current_scene.get_node("Player") as Player

func tick(enemy: Node, delta: float) -> void:
	if not active:
		return
	if player != null:
		var dir := (player.global_position - enemy.global_position).normalized()
		enemy.position += dir * move_speed * delta
		timer -= delta
		if timer <= 0.0:
			timer = interval
			var b := PoolManager.get_from_pool(&"enemy_bullets") as Bullet
			enemy.get_parent().add_child(b)
			b.fire(enemy.global_position, dir, bullet_speed, 1)
