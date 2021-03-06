extends Spatial

onready var pause_menu = $PauseMenu
onready var Global = get_node("/root/Global")



func _ready():
	pause_menu.visible = false
	prints("Global number", Global.number)



func _input(event):
	if event.is_action_released("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
	pass
