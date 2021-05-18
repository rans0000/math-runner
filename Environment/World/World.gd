extends Spatial

var pos = 0
var lowest_player_distance = 0
const BLOCK_WIDTH = 50
var players = []
var winning_player = ""
var finish_line_created = false

onready var pause_menu = $PauseMenu
onready var victory_menu = $VictoryMenu
onready var Global = get_node("/root/Global")
onready var desert_scene = preload("res://Environment/Desert/Desert.tscn")
onready var player_scene = preload("res://Player/Player.tscn")
onready var finish_line_scene = preload("res://Environment/FinishLine/FinishLine.tscn")
onready var h_box = $HBoxContainer



func _ready():
	reset_game()
	create_players()
	
	for _i in range(4):
		generate_world()



func reset_game():
	#Global.distance = 0.1
	get_tree().paused = false
	finish_line_created = false
	pause_menu.visible = false
	victory_menu.visible = false
	winning_player = ""
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
		if i == 1:
			set_player_material(player)
		h_box.add_child(vw_container)
		h_box.move_child(vw_container, 0)
	pass



func generate_world():
	var platform = desert_scene.instance()
	platform.transform.origin = Vector3(0, 0, -pos)
	call_deferred("add_child", platform)
	if !finish_line_created and Global.distance != INF and pos >= (Global.distance * 1000):
		build_finish_line(-pos)
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



func build_finish_line(finish_pos):
	var finish_line = finish_line_scene.instance()
	finish_line.transform.origin = Vector3(0, 1, finish_pos)
	finish_line.connect("player_wins", self, "on_player_wins")
	finish_line_created = true
	call_deferred("add_child", finish_line)
	pass



func on_player_wins(player_id):
	if winning_player:
		pass
	winning_player = String(player_id + 1)
	victory_menu.open_victory_dialog(player_id)



func set_player_material(player):
#	var model = player.get_node("PlayerSpatial/PlayerModel/Armature/Skeleton/Girl")
#	var overcoat = player.get_node("PlayerSpatial/PlayerModel/Armature/Skeleton/Overcoat")
#	var model_mat = SpatialMaterial.new()
#	var overcoat_mat = SpatialMaterial.new()
#	model_mat.albedo_color = Color("#4F2A20")
#	overcoat_mat.albedo_color = Color("#BD3D64")
#	model.set_material_override(7, model_mat)
#	overcoat.set_material_override(0, overcoat_mat)
	pass
