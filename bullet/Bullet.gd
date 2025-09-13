extends Area2D
class_name Bullet

@export var speed: float = 480.0
@export var damage: int = 1
@export var lifespan: float = 2.0
@export var team: int = 0

var velocity: Vector2 = Vector2.ZERO
var life: float = 0.0

func fire(from: Vector2, dir: Vector2, p_speed: float, p_team: int) -> void:
	position = from
	velocity = dir.normalized() * p_speed
	team = p_team
	life = lifespan
	if team == 0:
		add_to_group(&"player_bullet")
		remove_from_group(&"enemy_bullet")
	else:
		add_to_group(&"enemy_bullet")
		remove_from_group(&"player_bullet")
	Utils.activate(self)

func _physics_process(delta: float) -> void:
	position += velocity * delta
	life -= delta
	if life <= 0.0:
		PoolManager.return_to_pool(self)

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage") and area.get("team") != team:
		area.call("take_damage", damage)
		GameSignals.spawn_request.emit(&"hit_fx", global_position)
		PoolManager.return_to_pool(self)

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage") and body.get("team") != team:
		body.call("take_damage", damage)
		GameSignals.spawn_request.emit(&"hit_fx", global_position)
		PoolManager.return_to_pool(self)
