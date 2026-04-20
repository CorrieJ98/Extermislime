class_name BulletHandler extends Node2D

@onready var poolRef : Marker2D = $PoolReference

var bullets

func _init() -> void:
	bullets = get_node("Bullets").get_children(false) # DEBUG should populate with every instance of Bullet that is created
