extends Node2D

onready var player = get_node("/root/MainScene/Player")
onready var KillTimer = $KillTimer

export var speed = 750

func node_exists(nodePath) -> bool:
	if nodePath != null:
		return true
	else:
		return false

func _physics_process(delta):
	if node_exists(player) == true:
		position += transform.x * speed * delta

func _on_KillTimer_timeout():
	queue_free()


func _on_BulletArea_body_entered(body):
	if body == KinematicBody2D:
		queue_free()
