extends Node2D


onready var enemy = preload("res://Scenes/Enemy.tscn")
onready var spawn_point = $Sprite/Rotater/SpawnPoint
onready var spawn_timer = $SpawnTimer

var enemy_count = 5
var spawn_count = 3
var radius = 5

func _ready():
	pass

func spawn(enemy_count):
	for i in (enemy_count):
		var enemy = enemy.New()
	for i in enemy_count:
		if i <= enemy_count:
			var enemy = enemy.instance()
			get_tree().root.add_child(enemy)
			spawn_timer.start()
			i+1
			spawn(enemy_count)
		else:
			spawn_timer.stop()
			i = 0
			break

func _on_Timer_timeout():
	spawn(enemy_count)
