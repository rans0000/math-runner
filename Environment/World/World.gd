extends Spatial

var pos = 0
const BLOCK_WIDTH = 50

onready var pause_menu = $PauseMenu
onready var Global = get_node("/root/Global")
onready var desert_scene = preload("res://Environment/Desert/Desert.tscn")



func _ready():
	pause_menu.visible = false
	prints("Global number", Global.number)
	for i in range(4):
		generate_world()



func _input(event):
	if event.is_action_released("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
	pass



func generate_world():
	var platform = desert_scene.instance()
	platform.transform.origin = Vector3(0, 0, -pos)
	call_deferred("add_child", platform)
	pos += BLOCK_WIDTH
	pass
