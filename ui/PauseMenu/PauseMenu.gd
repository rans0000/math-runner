extends Control

onready var Global = get_node("/root/Global")


func _on_BtnClose_button_up():
	self.visible = false


func _on_BtnMainMenu_button_up():
	Global.goto_scene("res://ui/MainMenu/HomeScreen.tscn")
