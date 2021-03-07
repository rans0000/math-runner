extends KinematicBody

signal detect_empty_floor
signal detect_obsolete_floor(z_pos, platform)

const MAX_SPEED = 50
var velocity = Vector3()
var pos = Vector3()
const ACCELERATION = 20
var side = 0
const GRAVITY = 8
const ROAD_WIDTH = 3.5/2

onready var front_feeler = $FrontFeeler
onready var rear_feeler = $RearFeeler
onready var score_card = $ScoreCard



func _physics_process(delta):
	move_player(delta)
	check_floor()
	score_card.set_distance(-transform.origin.z)
	pass



func move_player(delta):
	velocity.x = 0
	velocity.y = 0
	velocity.z = move_forward(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	pass


func move_forward(delta):
	var fv = Vector3.FORWARD
	var new_pos = fv * MAX_SPEED
	var forward_velocity = fv.linear_interpolate(new_pos, ACCELERATION * delta)
	return forward_velocity.z



func _input(event):
	pass



func check_floor():
	if !front_feeler.is_colliding():
		emit_signal("detect_empty_floor")
	if rear_feeler.is_colliding():
		var target = rear_feeler.get_collider()
		if target.is_in_group("platform"):
			emit_signal("detect_obsolete_floor", transform.origin.z, target)
	pass
