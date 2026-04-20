class_name MainGame extends Node2D

@export var pool_handler : PackedScene
@export var bullet : PackedScene

@onready var audio_player = $AudioStreamPlayer
@onready var enemy = $Enemy
@onready var spawner = $Spawner
@onready var spawn_start = $SPAWN_START
var minute : int
var second : int 

## Send a game object to the object pool, and deactivate it
static func sendObjectInstanceToPool(obj, poolPos : Vector2, state : bool) -> void:
	obj.transform.position = poolPos
	obj.state = state;
	
	# TODO error handling

func _process(delta):
	if second == 60:
		add_count()

func add_count():
	minute += 1
	second -= 60

func _on_Timer_timeout():
	second += 1
