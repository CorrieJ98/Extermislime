class_name Bullet extends Node2D

@onready var kill_timer: Timer = $KillTimer
@export var speed: float = 750

var active: bool = false
var direction: Vector2 = Vector2.ZERO


func _ready():
	poolBullet(Vector2(-10000, -10000))


func unpoolBullet() -> void:
	active = true
	
	visible = true
	set_physics_process(true)
	set_process(true)

	direction = Vector2.ZERO

	kill_timer.stop()
	kill_timer.start()


func poolBullet(pos: Vector2) -> void:
	active = false
	
	global_position = pos
	
	visible = false
	set_physics_process(false)
	set_process(false)

	kill_timer.stop()


func _physics_process(delta):
	if not active:
		return
	
	position += direction * speed * delta


func _on_KillTimer_timeout():
	recycle_self()


func _on_BulletArea_body_entered(body):
	if body is CharacterBody2D:
		recycle_self()


func recycle_self():
	get_parent().get_node("PoolManager").recycle(self)
