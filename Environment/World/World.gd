extends Spatial

var pos = 0
var lowest_player_distance = 0
const BLOCK_WIDTH = 50
var players = []

onready var pause_menu = $PauseMenu
onready var Global = get_node("/root/Global")
onready var desert_scene = preload("res://Environment/Desert/Desert.tscn")
onready var player_scene = preload("res://Player/Player.tscn")
onready var h_box = $HBoxContainer



func _ready():
	pause_menu.visible = false
	create_players()
	
	for _i in range(4):
		generate_world()



func _input(event):
	if event.is_action_released("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
	pass



func create_players():
	var player_count = Global.play_type
	for i in range(player_count):
		var vw_container = ViewportContainer.new()
		var viewport = Viewport.new()
		
		var player = player_scene.instance()
		player.side = i
		player.id = i
		player.connect("detect_empty_floor", self, "generate_world")
		player.connect("detect_obsolete_floor", self, "delete_floor")
		players.append(player)
		
		viewport.add_child(player)
		vw_container.add_child(viewport)
		vw_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
		vw_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vw_container.anchor_right = 1.0
		vw_container.anchor_bottom = 1.0
		vw_container.stretch = true
		viewport.handle_input_locally = true
		viewport.render_target_update_mode = 0
		viewport.gui_disable_input = true
		h_box.add_child(vw_container)
		h_box.move_child(vw_container, 0)
	pass



func generate_world():
	var platform = desert_scene.instance()
	platform.transform.origin = Vector3(0, 0, -pos)
	call_deferred("add_child", platform)
	pos += BLOCK_WIDTH
	pass



func delete_floor(pos_z, platform):
	var min_pos = -players[0].transform.origin.z
	for player in players:
		var z_pos = -player.transform.origin.z
		min_pos = z_pos if z_pos < min_pos else min_pos
	if(pos_z <= min_pos):
		platform.queue_free()
		lowest_player_distance = pos_z
	pass
