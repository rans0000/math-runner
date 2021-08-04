extends Control
const ONE_KM = 1000
onready var distance_label = $ScoreBox/HBoxContainer/DistanceLabel


func set_distance(distance):
	var dist_text
	if distance < ONE_KM:
		dist_text = "%d m" % [distance]
	else:
		dist_text = "%.2f Km" % [distance/ONE_KM]
	distance_label.text = dist_text
	pass
