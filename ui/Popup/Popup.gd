extends Popup

onready var button_wrapper = $CenterContainer/VBoxContainer/ButtonWrapper
onready var Global = get_node("/root/Global")



func _ready():
	for i in range(10):
		var button = Button.new()
		button.text = String(i + 1)
		button.connect("button_up", self, "on_number_select", [i+1])
		button_wrapper.add_child(button)
	pass



func _on_BtnClose_button_up():
	self.visible = false



func on_number_select(number):
	print(number)
	Global.number = number
	Global.goto_scene("res://Environment/World/World.tscn")
	pass
