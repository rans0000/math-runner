extends Control
const ONE_KM = 1000
onready var distance_label = $ScoreBox/HBoxContainer/DistanceLabel
onready var score_label = $ScoreBox/HBoxContainer/ScoreLabel
onready var boost_rect = $ScoreBox/HBoxContainer/CenterContainer/BoostRect
onready var boost_icon = preload("res://ui/Themes/MainTheme/Textures/status_sprint_icon.png")
onready var penalty_icon = preload("res://ui/Themes/MainTheme/Textures/status_ghost_icon.png")


func set_distance(distance):
	var dist_text
	if distance < ONE_KM:
		dist_text = "%d m" % [distance]
	else:
		dist_text = "%.2f Km" % [distance/ONE_KM]
	distance_label.text = dist_text
	pass

func set_score(score):
	score_label.text = "%d" % score

func set_boost(boost):
	if(boost == Global.STATUS.SPRINT):
		boost_rect.set("texture", boost_icon)
	elif (boost == Global.STATUS.PENALTY):
		boost_rect.set("texture", penalty_icon)
	else:
		boost_rect.texture = null
	pass
