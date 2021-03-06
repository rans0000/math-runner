extends Spatial

const BLOCK_WIDTH = 50/2
const ROAD_WIDTH = 3.5/2

onready var sand_scene = preload("res://Environment/Desert/DesertSand.tscn")
onready var road_scene = preload("res://Environment/Desert/DesertRoad.tscn")



func _ready():
	generate_world()
	pass



func generate_world():
	for i in range(2):
		var sand = sand_scene.instance()
		var x_flip = (1 if i == 0 else -1)
		var x_pos = BLOCK_WIDTH + ROAD_WIDTH
		var rand_rot = (randi() % 4) * 90
		sand.rotate_y(deg2rad(rand_rot))
		sand.transform.origin = Vector3(x_flip * x_pos, 0, 0)
		call_deferred("add_child", sand)
		i+=1
	var road = road_scene.instance()
	road.transform.origin = Vector3(0, 0, 0)
	call_deferred("add_child", road)
	pass
