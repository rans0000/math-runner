extends Spatial

var number = 0

onready var display = $Display



func _ready():
	display.text = String(number)



func set_number(_num):
	number = _num
	display.text = String(number)


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if Global.is_sprint(number):
			body.sprint()
		else:
			body.slow_down()
	pass
