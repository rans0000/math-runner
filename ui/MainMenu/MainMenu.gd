extends Control

onready var popup = $Popup/Popup;
onready var Global = get_node("/root/Global")



func _on_BtnPlay_button_up():
	Global.play_type = Global.PLAY_TYPES.LOC_SINGLE
	popup.visible = !popup.visible
	pass



func _on_BtnPlay2_button_up():
	Global.play_type = Global.PLAY_TYPES.LOC_2_PLAYER
	popup.visible = !popup.visible
