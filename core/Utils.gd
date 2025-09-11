class_name Utils

static func activate(node: Node) -> void:
	if node is CanvasItem:
		node.visible = true
	if node is Area2D:
		node.monitoring = true
	node.set_process(true)
	node.set_physics_process(true)

static func deactivate(node: Node) -> void:
	if node is CanvasItem:
		node.visible = false
	if node is Area2D:
		node.monitoring = false
	node.set_process(false)
	node.set_physics_process(false)
