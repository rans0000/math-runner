extends Control

onready var button_wrapper = $Popup/MarginContainer/Panel/CenterContainer/VBoxContainer/ButtonWrapper
#onready var btn_numeric = $CenterContainer/VBoxContainer/ButtonWrapper/BtnNumeric
onready var btn_numeric = $Popup/MarginContainer/Panel/CenterContainer/VBoxContainer/ButtonWrapper/BtnNumeric
onready var Global = get_node("/root/Global")
onready var popup = $Popup



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
