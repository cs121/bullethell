extends Node2D
class_name Enemy

@onready var health: HealthComponent = $HealthComponent
@onready var movement: MovementComponent = $MovementComponent
var pool: ObjectPool

func _ready() -> void:
	health.died.connect(_on_died)

func activate(pos: Vector2, pool_ref: ObjectPool) -> void:
	position = pos
	pool = pool_ref
	visible = true
	health.reset()
	set_process(true)

func _process(delta: float) -> void:
	position += movement.get_velocity() * delta
	if position.y > get_viewport_rect().size.y + 50.0:
		_deactivate()

func _on_died() -> void:
	GameManager.on_enemy_killed()
	GameManager.spawn_hit_effect(global_position)
	_deactivate()

func _deactivate() -> void:
	set_process(false)
	visible = false
	if is_instance_valid(pool):
		pool.release_instance(self)
