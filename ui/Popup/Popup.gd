extends Control

onready var Global = get_node("/root/Global")
onready var popup = $Popup
export (NodePath) var button_wrapper_node
export (NodePath) var btn_numeric_node
onready var button_wrapper = get_node(button_wrapper_node)
onready var btn_numeric = get_node(btn_numeric_node)



func _ready():
	for i in range(10):
		var button = btn_numeric.duplicate()
		button.text = String(i + 1)
		button.visible = true
		button.connect("button_up", self, "on_number_select", [i+1])
		button_wrapper.add_child(button)
	pass



func _on_BtnClose_button_up():
	popup.visible = false



func on_number_select(number):
	Global.number = number
	Global.goto_scene("res://Environment/World/World.tscn")
	pass
