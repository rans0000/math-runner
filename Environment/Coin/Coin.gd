extends Spatial

var number = 0

onready var display = $Display



func _ready():
	number = Global.rng.randi_range(0, 99)
	display.text = String(number)



func set_number(_num):
	number = _num
	display.text = String(number)


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if Global.is_sprint(number):
			body.sprint(number)
		else:
			body.slow_down()
		call_deferred("free")
	pass
