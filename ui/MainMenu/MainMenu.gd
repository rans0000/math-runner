extends Control

onready var popup = $Popup;

func _on_BtnPlay_button_up():
	popup.visible = !popup.visible
	pass
