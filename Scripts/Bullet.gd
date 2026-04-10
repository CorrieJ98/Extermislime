class_name Bullet extends Node2D

@onready var KillTimer = $KillTimer

@export var speed : float = 750 

var state : bool = false

func _on_KillTimer_timeout():
	MainGame.sendObjectInstanceToPool(self,Vector2(-100,100), false)

func _on_BulletArea_body_entered(body):
	if body == CharacterBody2D:
		MainGame.sendObjectInstanceToPool(self,Vector2(-100,100), false)
