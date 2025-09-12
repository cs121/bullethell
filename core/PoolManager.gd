extends Node
class_name Pool_Manager

@export var bullet_scene: PackedScene = preload("res://bullet/Bullet.tscn")
@export var enemy_scene: PackedScene = preload("res://enemy/Enemy.tscn")
@export var hit_fx_scene: PackedScene = preload("res://fx/HitSpark.tscn")
@export var player_bullet_count: int = 64
@export var enemy_bullet_count: int = 128
@export var enemy_count: int = 32
@export var hit_fx_count: int = 32

var pools: Dictionary[StringName, Array] = {}
var scene_map: Dictionary[StringName, PackedScene] = {}

func _ready() -> void:
	scene_map = {
		&"player_bullets": bullet_scene,
		&"enemy_bullets": bullet_scene,
		&"enemies": enemy_scene,
		&"hit_fx": hit_fx_scene
	}
	_prewarm(&"player_bullets", player_bullet_count)
	_prewarm(&"enemy_bullets", enemy_bullet_count)
	_prewarm(&"enemies", enemy_count)
	_prewarm(&"hit_fx", hit_fx_count)

func _prewarm(type: StringName, count: int) -> void:
	var scene := scene_map[type]
	var pool: Array = []
	for i in count:
		var node := scene.instantiate()
		node.set_meta("pool_type", type)
		Utils.deactivate(node)
		add_child(node)
		pool.append(node)
	pools[type] = pool

func get_from_pool(type: StringName) -> Node:
	var pool: Array = pools.get(type, [])
	var node: Node
	if pool.size() > 0:
		node = pool.pop_back()
		if node.get_parent() != null:
			node.get_parent().remove_child(node)
	else:
		node = scene_map[type].instantiate()
		node.set_meta("pool_type", type)
	return node

func return_to_pool(node: Node) -> void:
	var type: StringName = node.get_meta("pool_type")
	Utils.deactivate(node)
	remove_child(node)
	pools[type].append(node)
	add_child(node)
