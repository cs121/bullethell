extends Node
class_name ObjectPool

@export var scene: PackedScene
@export var size: int = 16

var available: Array[Node] = []
var in_use: Array[Node] = []

func _ready() -> void:
	for i in size:
		var inst := scene.instantiate()
		inst.visible = false
		add_child(inst)
		available.push_back(inst)

func get_instance() -> Node:
	if available.is_empty():
		return null
	var inst := available.pop_back()
	in_use.push_back(inst)
	inst.visible = true
	return inst

func release_instance(node: Node) -> void:
	if not in_use.has(node):
		return
	in_use.erase(node)
	node.visible = false
	available.push_back(node)
