extends Node2D

onready var player = get_node("/root/MainScene/Player")
onready var enemy = get_node("/root/MainScene/Enemy")
onready var KillTimer = $KillTimer

export var speed = 750


func _physics_process(delta):
	position += transform.x * (speed + player.moveSpeed) * delta

func _on_KillTimer_timeout() -> void:
	queue_free()
