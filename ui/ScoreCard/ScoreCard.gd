extends Control

onready var distance_display = $VBoxContainer/DistanceDisplay

func set_distance(distance):
	distance_display.text = String(int(distance))
	pass
