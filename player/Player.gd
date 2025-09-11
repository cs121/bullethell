extends CharacterBody2D
class_name Player

@onready var movement: MovementComponent = $MovementComponent
@onready var weapon: WeaponComponent = $WeaponComponent
@onready var health: HealthComponent = $HealthComponent

func _ready() -> void:
	health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement.set_input(dir)
	velocity = movement.get_velocity()
	move_and_slide()
	if Input.is_action_pressed("shoot"):
		weapon.shoot(global_position)

func _on_died() -> void:
	hide()
