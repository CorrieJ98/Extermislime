extends "res://Position2D.gd"

export var spawningRange = 100.00
onready var spawner = get_node("/root/MainScene/RadialSpawner")
onready var timer = $IncreaseEnemies
var t = 2
var t10 : int


func spawn():
	var enemy = .spawn()
	var radialOffset = Vector2.RIGHT.rotated(rand_range(0.0,TAU))
	radialOffset *= rand_range(0.0,spawningRange)
	
	enemy.global_position += radialOffset
	return enemy

func _on_IncreaseEnemies_timeout():
	t += 1
	if spawner.get_child_count() <= t:
		spawn()
