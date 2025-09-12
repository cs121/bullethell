extends Area2D
class_name Enemy

@export var max_hp: int = 3
@export var point_value: int = 50
@export var contact_damage: int = 1

var hp: int = 0
var team: int = 1
var pattern: PatternBase = null
@onready var patterns: Node = $Patterns

func activate(pos: Vector2, pattern_name: StringName, params: Dictionary = {}) -> void:
	position = pos
	hp = max_hp
	pattern = null
	for child in patterns.get_children():
		var p := child as PatternBase
		p.set_active(false)
		if child.name == pattern_name:
			pattern = p
			p.set_active(true)
			p.setup(self, params)
	Utils.activate(self)

func _physics_process(delta: float) -> void:
	if pattern != null:
		pattern.tick(self, delta)

func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		GameSignals.enemy_killed.emit(point_value)
		GameSignals.play_sfx.emit(&"explosion")
		GameSignals.spawn_request.emit(&"hit_fx", global_position)
		GameSignals.spawn_request.emit(&"star", global_position)
		PoolManager.return_to_pool(self)
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage") and body.get("team") != team:
		body.call("take_damage", contact_damage)
		PoolManager.return_to_pool(self)
