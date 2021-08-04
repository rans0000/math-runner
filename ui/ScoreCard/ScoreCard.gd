extends Control
const ONE_KM = 1000
onready var distance_label = $ScoreBox/HBoxContainer/DistanceLabel
onready var score_label = $ScoreBox/HBoxContainer/ScoreLabel


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
