extends Spatial

const BLOCK_WIDTH = 50/2
const ROAD_WIDTH = 3.5/2
const MIN_COIN_DISTANCE = 5
export var generate_coins: bool = true

onready var sand_left = $DesertSand1
onready var sand_right = $DesertSand2
onready var coin_scene = preload("res://Environment/Coin/Coin.tscn")



func _ready():
	place_sand()
	if generate_coins:
		place_coins()
	pass



func place_sand():
	var rand_rot = (randi() % 4) * 90
	sand_left.rotate_y(deg2rad(rand_rot))
	rand_rot = (randi() % 4) * 90
	sand_right.rotate_y(deg2rad(rand_rot))
	pass



func place_coins():
	var board_width = BLOCK_WIDTH * 2
	var z_pos = Global.rng.randi_range(MIN_COIN_DISTANCE, board_width - MIN_COIN_DISTANCE)
	while z_pos < (board_width - MIN_COIN_DISTANCE):
		var side = Global.rng.randi_range(-1,1)
		var coin = coin_scene.instance()
		var t_pos = z_pos - BLOCK_WIDTH
		coin.transform.origin = Vector3(ROAD_WIDTH * side, 1, t_pos)
		call_deferred("add_child", coin)
		z_pos = Global.rng.randi_range(z_pos + MIN_COIN_DISTANCE, board_width)
	pass
