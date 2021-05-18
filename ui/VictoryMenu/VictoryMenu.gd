extends Control

export (NodePath) var victory_mssg_node
onready var Global = get_node("/root/Global")
onready var victory_mssg = get_node(victory_mssg_node)


func open_victory_dialog(player_id):
	victory_mssg.text = "Player " + String(player_id + 1) + " wins"
	var t = Timer.new()
	t.wait_time = 0.5
	t.one_shot = true
	add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	visible = !visible
	get_tree().paused = visible
	pass



func _on_BtnMainMenu_pressed():
	visible = false
	get_tree().paused = false
	Global.goto_scene("res://ui/MainMenu/HomeScreen.tscn")
