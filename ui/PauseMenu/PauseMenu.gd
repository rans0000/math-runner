extends Control

onready var Global = get_node("/root/Global")



func _input(event):
	if event.is_action_released("ui_cancel"):
		visible = !visible
		get_tree().paused = visible
	pass



func _on_BtnClose_button_up():
	self.visible = false
	get_tree().paused = false



func _on_BtnMainMenu_button_up():
	get_tree().paused = false
	Global.goto_scene("res://ui/MainMenu/HomeScreen.tscn")
