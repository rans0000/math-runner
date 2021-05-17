extends Control

var regex = RegEx.new()
var prev_distance = ""
onready var Global = get_node("/root/Global")
onready var popup = $Popup
export (NodePath) var button_wrapper_node
export (NodePath) var btn_numeric_node
export (NodePath) var distance_input_node
export (NodePath) var error_text_node
onready var button_wrapper = get_node(button_wrapper_node)
onready var btn_numeric = get_node(btn_numeric_node)
onready var input_distance = get_node(distance_input_node)
onready var error_text = get_node(error_text_node)



func _ready():
	regex.compile("^[0-9]*$")
	prev_distance = String(Global.distance)
	input_distance.set_text(prev_distance)
	
	for i in range(2,10):
		var button = btn_numeric.duplicate()
		button.text = String(i)
		button.visible = true
		button.connect("button_up", self, "on_number_select", [i])
		button_wrapper.add_child(button)
		button.set_pressed(Global.number == i)
	pass



func _on_BtnClose_button_up():
	popup.visible = false



func _on_BtnPlay_button_up():
	var dist = input_distance.get_text()
	var distance = int(dist) if validate_distance(dist) else INF
	Global.distance = distance
	popup.visible = false
	Global.goto_scene("res://Environment/World/World.tscn")



func on_number_select(number):
	Global.number = number
	pass



func _on_InputDistance_text_changed(new_text):
	var text = ""
	var reg_result = regex.search(new_text)
	if reg_result:
		text = new_text
		prev_distance = new_text
	else:
		text = prev_distance
	input_distance.set_text(text)
	input_distance.set_cursor_position(text.length())
	toggle_error_mssg(text)



func toggle_error_mssg(text):
	error_text.visible = !validate_distance(text)



func validate_distance(text):
	return !(text.length() == 0 or text == "0" or text == "00")



func _on_popup_toggle():
	toggle_error_mssg(prev_distance)
