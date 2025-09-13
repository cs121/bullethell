extends CharacterBody2D
class_name Player

@export var speed: float = 220.0
@export var fire_rate: float = 8.0
@export var bullet_speed: float = 480.0
@export var invincible_time: float = 1.0
@export var bombs: int = 3

var shoot_cd: float = 0.0
var invincible: float = 0.0
var team: int = 0
var current_weapon: int = 0
var weapons: Array[StringName] = [&"default"]

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_shooting(delta)
	_handle_specials()
	if invincible > 0.0:
		invincible -= delta

func _handle_movement(delta: float) -> void:
	# Use Input.get_vector to support both keyboard and gamepad movement
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
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


func _handle_specials() -> void:
	# Special weapon activation
	if Input.is_action_just_pressed(&"special_weapon") and bombs > 0:
		bombs -= 1
		GameSignals.bomb_used.emit(bombs)
		_activate_bomb()
	# Cycle through available weapons
	if Input.is_action_just_pressed(&"switch_weapon"):
		current_weapon = (current_weapon + 1) % weapons.size()

func _activate_bomb() -> void:
	# Remove all enemy bullets currently on screen
	for b in get_tree().get_nodes_in_group("enemy_bullet"):
		if b.get_parent() != PoolManager:
			PoolManager.return_to_pool(b)
	GameSignals.play_sfx.emit(&"explosion")

func take_damage(amount: int) -> void:
	if invincible > 0.0:
		return
	invincible = invincible_time
	GameSignals.player_hit.emit(amount)
	GameManager.on_player_death()
	queue_free()
