class_name Enemy extends CharacterBody2D

var state : bool = false

@export var moveSpeed : float = 150.0 ## how fast the unit moves
@export var maxHp : int = 50
@export var curHp : int = 5
@export var damage : int = 30
@export var attackDist : float = 80.0
@export var score : int = 18

var vel : Vector2 = Vector2()
var isAttacking = false
var dying = false

@onready var target = get_node("/root/MainScene/Player")
@onready var bullet = $Bullet
@onready var anim = $Sprite/Area2D/AnimationPlayer
@onready var atkHB = $Sprite/Area2D/AtkHitbox
@onready var slimeHB = $CollisionShape2D
@onready var sprite = $Sprite
@onready var area2d = $Sprite/Area2D

func _physics_process(delta):
	if(!state): return
	
	var dist = position.distance_to(target.position)
	dir_check()
	
	move_and_slide()
	vel = (target.position - position).normalized()
	
	if dist > attackDist:
		if dying == false:
			anim.play("idle")
			isAttacking = false
	
	if dist <= attackDist:
		anim_handling("attack")

func anim_handling(anim_name):
	if anim.current_animation != anim_name and isAttacking == false:
		anim.play(anim_name)
		isAttacking = true

func dir_check():
		if vel.x < 0:
			sprite.flip_h = true
			area2d.scale.x = -1
		elif vel.x > 0:
			sprite.flip_h = false
			area2d.scale.x = 1

func _on_Area2D_area_entered(area):
	if area.name == "BulletArea":
		if dying == false:
			dying = true
			anim_handling("death")
			isAttacking = true
			anim.play("death")
			var t = $Timer
			t.start()

func _on_Timer_timeout():
	die()

func die():
	target.scoring(score)
	queue_free()

func take_damage(damage):
	curHp -= damage
	if curHp <= 0:
		vel = Vector2(0,0)
		die()


func _on_Area2D_body_entered(body):
	if body == target:
		target.take_damage(damage)
