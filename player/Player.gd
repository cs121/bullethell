extends CharacterBody2D
class_name Player

@export var speed: float = 220.0
@export var fire_rate: float = 8.0
@export var bullet_speed: float = 480.0
@export var lives: int = 3
@export var invincible_time: float = 1.0

var shoot_cd: float = 0.0
var invincible: float = 0.0
var team: int = 0

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_shooting(delta)
	if invincible > 0.0:
		invincible -= delta

func _handle_movement(delta: float) -> void:
	var input_vec := Vector2.ZERO
	if Input.is_action_pressed(&"move_left"):
		input_vec.x -= 1.0
	if Input.is_action_pressed(&"move_right"):
		input_vec.x += 1.0
	if Input.is_action_pressed(&"move_up"):
		input_vec.y -= 1.0
	if Input.is_action_pressed(&"move_down"):
		input_vec.y += 1.0
	input_vec = input_vec.normalized()
	var current_speed := speed
	if Input.is_action_pressed(&"focus"):
		current_speed *= 0.5
	velocity = input_vec * current_speed
	move_and_slide()

func _handle_shooting(delta: float) -> void:
	shoot_cd -= delta
	if shoot_cd <= 0.0 and Input.is_action_pressed(&"shoot"):
		shoot_cd = 1.0 / fire_rate
		var b := PoolManager.get_from_pool(&"player_bullets") as Bullet
		get_tree().current_scene.add_child(b)
		b.fire(global_position, Vector2.UP, bullet_speed, team)
		GameSignals.play_sfx.emit(&"shoot")

func take_damage(amount: int) -> void:
	if invincible > 0.0:
		return
	lives -= amount
	invincible = invincible_time
	GameSignals.player_hit.emit(amount)
	if lives <= 0:
		queue_free()
