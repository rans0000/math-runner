extends Node

var current_scene = null
enum PLAY_TYPES {LOC_SINGLE = 1, LOC_2_PLAYER = 2}
var play_type = PLAY_TYPES.LOC_SINGLE
onready var number = 0


func _ready():
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)



func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)



func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	pass
