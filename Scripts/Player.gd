extends CharacterBody2D

@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
@onready var sprite = $Sprite
@onready var ui = $Camera2D/UI
const bullet_scene = preload("res://Scenes/Bullet.tscn") # FIXME change to an export, customise bullets
@export var rotate_speed = 60
@export var shooter_timer_wait_time = 0.3
@export var spawn_point_count = 3
var sprintX = 2.4
var crouchX = 0.4
var maxHP = 100
var curHP = 100
var score : int = 0
var max_score : int = 0
var scoreX = 1
var moveSpeed = 250
var vel : Vector2 = Vector2()
var facingDir: Vector2 = Vector2()
var input_held = false
var radius = 5

func _ready():
	ui.update_health_bar(curHP, maxHP)

func _physics_process(delta):
	if facingDir.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	# -------------------- keybinds --------------------
	vel = Vector2()
	if Input.is_action_pressed("move_north"):
		vel.y -= moveSpeed
		facingDir = Vector2(0,1)

	if Input.is_action_pressed("move_south"):
		vel.y += moveSpeed
		facingDir = Vector2(0,-1)

	if Input.is_action_pressed("move_east"):
		vel.x += moveSpeed
		facingDir = Vector2(1,0)

	if Input.is_action_pressed("move_west"):
		vel.x -= moveSpeed
		facingDir = Vector2(-1,0)
	
	if Input.is_action_just_pressed("move_sprint"):
		moveSpeed *= sprintX
	elif Input.is_action_just_released("move_sprint"):
		moveSpeed /= sprintX
	
	if Input.is_action_just_pressed("move_crouch"):
		moveSpeed *= crouchX
	elif Input.is_action_just_released("move_crouch"):
		moveSpeed /= crouchX
	
	if Input.is_action_just_pressed("audio_ping"):
		if Input.is_action_pressed("audio_ping"):
			input_held = true
			ping()
	
	if Input.is_action_just_released("audio_ping"):
		input_held = false
	
	vel = vel.normalized()
	move_and_slide()
	
	if score < max_score:
		if max_score < 200:
			score += 1
		if max_score < 1000:
			score += 10
		else:
			score += (max_score*0.001)
	
	ui.update_score(score)

func ping():
	
	# audio pings
	var step = TAU / spawn_point_count
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	
	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()

func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _on_Timer_timeout():
	if input_held == true:
		for s in rotater.get_children():
			var bullet = bullet_scene.instance() # FIXME absolutely lose this
			get_tree().root.add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation

func die():
	get_tree().reload_current_scene()
	# TODO profile this and manually garbage collect if needed
	

func take_damage(damage):
	curHP -= damage
	scoreX = 1
	ui.update_health_bar(curHP,maxHP)
	if curHP <= 0:
		die()

func scoring(add_score):
	max_score += (add_score * scoreX)
	scoreX += 1
