extends Node

var current_scene = null
enum PLAY_TYPES {LOC_SINGLE = 1, LOC_2_PLAYER = 2}
enum SIDE {LEFT = -1, CENTER = 0, RIGHT = 1}
var play_type = PLAY_TYPES.LOC_SINGLE
onready var number = 5
var rng


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
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



func clamp_vector(vector, length):
	var norm = vector.normalized()
	if vector.length() > length:
		vector = norm * length
	return vector



func is_sprint(hit_number):
	return (hit_number % number == 0)
