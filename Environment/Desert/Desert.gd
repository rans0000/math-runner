extends Spatial

const BLOCK_WIDTH = 50/2
const ROAD_WIDTH = 3.5/2

onready var sand_left = $DesertSand1
onready var sand_right = $DesertSand2



func _ready():
	place_sand()
	pass



func place_sand():
	var rand_rot = (randi() % 4) * 90
	sand_left.rotate_y(deg2rad(rand_rot))
	rand_rot = (randi() % 4) * 90
	sand_right.rotate_y(deg2rad(rand_rot))
	pass
