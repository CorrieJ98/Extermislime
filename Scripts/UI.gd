extends Control

@onready var main = get_parent().get_parent().get_parent()
@onready var levelText = $NinePatchRect/LevelBG/ScoreText
@onready var healthBar = $NinePatchRect/HP_Bar
@onready var timerText = $NinePatchRect/TimerText

func _process(delta):
	timerText.text = str(main.minute, " m ", main.second, " s")

func update_health_bar(curHP, maxHP):
	healthBar.value = (100/maxHP) * curHP

func update_score(score):
	levelText.text = str(score)
