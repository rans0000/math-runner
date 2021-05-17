extends Control

var regex = RegEx.new()
var prev_distance
onready var Global = get_node("/root/Global")
onready var popup = $Popup
export (NodePath) var button_wrapper_node
export (NodePath) var btn_numeric_node
export (NodePath) var distance_input_node
onready var button_wrapper = get_node(button_wrapper_node)
onready var btn_numeric = get_node(btn_numeric_node)
onready var input_distance = get_node(distance_input_node)



func _ready():
	prev_distance = String(Global.distance)
	regex.compile("^[0-9]+$")
	input_distance.text = prev_distance
	for i in range(2,10):
		var button = btn_numeric.duplicate()
		button.text = String(i)
		button.visible = true
		button.connect("button_up", self, "on_number_select", [i])
		button_wrapper.add_child(button)
	pass



func _on_BtnClose_button_up():
	popup.visible = false



func _on_BtnPlay_button_up():
	Global.goto_scene("res://Environment/World/World.tscn")



func on_number_select(number):
	Global.number = number
	pass



func _on_InputDistance_text_changed():
	var new_text = input_distance.get_text()
	var text = ""
	var reg_result = regex.search(new_text)
	if reg_result:
		print(reg_result.get_string())
		text = new_text
		prev_distance = new_text
	else:
		print("----")
		text = prev_distance
	input_distance.set_text(text)
	input_distance.cursor_set_column(text.length())
	print(text)
