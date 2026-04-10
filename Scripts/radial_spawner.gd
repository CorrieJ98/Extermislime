class_name Spawner extends Marker2D

## Set the max extreme of the spawn radius, taken as EITHER axis of a vector (0,VAL) or (VAL,0). True value should be taken as about 1/sqrt(2) or ~71% of true value for pythagorean reasons.
@export var max_spawn_radius : float = 10 
@export var enemy_to_spawn : Enemy

## debug export - remove on release
@export var next_spawn_coords : Vector2 

func spawnEnemy(enemy : Enemy, position : Vector2) -> void:
	enemy

func generateRandomSpawnCoords() -> Vector2:
	var x = randf_range(-max_spawn_radius,max_spawn_radius)
	var y = randf_range(-max_spawn_radius,max_spawn_radius)
	
	return Vector2(x,y)
