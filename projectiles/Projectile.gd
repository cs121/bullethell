extends Area2D
class_name Projectile

@export var speed: float = 400.0

var velocity: Vector2 = Vector2.ZERO
var pool: ObjectPool

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func activate(pos: Vector2, dir: Vector2, pool_ref: ObjectPool) -> void:
	position = pos
	velocity = dir.normalized() * speed
	pool = pool_ref
	visible = true
	collision.disabled = false

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(1)
	GameManager.spawn_hit_effect(global_position)
	_deactivate()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_deactivate()

func _deactivate() -> void:
	collision.disabled = true
	visible = false
	if is_instance_valid(pool):
		pool.release_instance(self)
