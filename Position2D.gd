extends Position2D

export(PackedScene) var enemyScene


func spawn():
	var enemy = enemyScene.instance()
	
	add_child(enemy)
	enemy.set_as_toplevel(true)
	enemy.global_position = global_position
	
	return enemy
