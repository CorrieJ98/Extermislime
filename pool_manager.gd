extends Node

# { PackedScene : Array[Node] }
var pools: Dictionary = {}

# NEW: { Node : PackedScene }
var instance_to_scene: Dictionary = {}

var default_prewarm := 10


func getScene(scene: PackedScene, parent: Node, pos: Vector2) -> Node:
	if not pools.has(scene):
		pools[scene] = []
		_prewarm(scene, parent, default_prewarm)

	var pool: Array = pools[scene]

	var instance: Node
	if pool.is_empty():
		instance = scene.instantiate()
		parent.add_child(instance)

		# Track ownership
		instance_to_scene[instance] = scene
	else:
		instance = pool.pop_back()

	# Reset basic state
	instance.global_position = pos
	
	if instance.has_method("unpoolBullet"):
		instance.unpoolBullet()

	return instance


func recycle(instance: Node):
	if not instance_to_scene.has(instance):
		push_warning("Tried to recycle unknown instance: %s" % instance)
		return

	var scene: PackedScene = instance_to_scene[instance]

	if not pools.has(scene):
		pools[scene] = []

	# Pool it
	if instance.has_method("poolBullet"):
		instance.poolBullet(Vector2(-10000, -10000))

	pools[scene].append(instance)


func _prewarm(scene: PackedScene, parent: Node, count: int):
	for i in count:
		var inst = scene.instantiate()
		parent.add_child(inst)

		instance_to_scene[inst] = scene

		if inst.has_method("poolBullet"):
			inst.poolBullet(Vector2(-10000, -10000))

		pools[scene].append(inst)
