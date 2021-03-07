extends Spatial

var pos = 0
const BLOCK_WIDTH = 50

onready var pause_menu = $PauseMenu
onready var Global = get_node("/root/Global")
onready var desert_scene = preload("res://Environment/Desert/Desert.tscn")
#onready var player = $Player



func _ready():
	pause_menu.visible = false
	prints("Global number", Global.number)
#	player.connect("detect_empty_floor", self, "generate_world")
#	player.connect("detect_obsolete_floor", self, "delete_floor")
	for player in get_tree().get_nodes_in_group("player"):
		player.connect("detect_empty_floor", self, "generate_world")
		player.connect("detect_obsolete_floor", self, "delete_floor")
	
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



func delete_floor(pos_z, platform):
	return
	platform.queue_free()
	pass
