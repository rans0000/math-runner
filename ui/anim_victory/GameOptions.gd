extends Control

onready var popup = $MarginContainer/CenterContainer/Popup
var is_visible = false


func _ready():
	pass



func set_popup_visibility(visibility):
	is_visible = visibility
	popup.visible = is_visible
	mouse_filter = Control.MOUSE_FILTER_STOP if visibility else Control.MOUSE_FILTER_PASS
	pass



func _on_CloseButton_pressed():
	set_popup_visibility(false)
