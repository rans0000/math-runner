extends KinematicBody

signal detect_empty_floor
signal detect_obsolete_floor(z_pos, platform)

export(int) var FORWARD_SPEED_REGULAR = 15
export(int) var FORWARD_SPEED_BONUS = 40
export(int) var FORWARD_SPEED_PENALTY = 5
var id
var forward_speed = FORWARD_SPEED_REGULAR
var velocity = Vector3()
var pos = Vector3()
const ACCELERATION = 0.5
export (Global.SIDE) var side = Global.SIDE.CENTER
const SIDE_WIDTH = 3
const GRAVITY = 8
const ROAD_WIDTH = 3.5/2
const STANCE_IDLE = 0
const STANCE_WALK = 0.5
const STANCE_RUN = 1
const STRAFE_SPEED = 1000
const SCORE_INCREMENT = 10
var score = 0
var anim_stance = "parameters/anim_stance/blend_position"
var anim_strafe_mode = "parameters/anim_strafe/blend_position"
var anim_strafe = "parameters/anim_strafe_oneshot/active"
var anim_head_hit = "parameters/anim_head_hit_oneshot/active"
var anim_victory = "parameters/anim_victory_oneshot/active"

onready var front_feeler = $FrontFeeler
onready var rear_feeler = $RearFeeler
onready var score_card = $ScoreCard
onready var animation_tree = $AnimationTree
onready var left_feeler = $LeftFeeler
onready var right_feeler = $RightFeeler
onready var speed_timer = $SpeedTimer
onready var score_feedback = $ScoreHitFeedback
#onready var tt = $PlayerSpatial/PlayerModel/Armature/Skeleton/Overcoat



func _ready():
	set_initial_position(side)
	#seting multiplier to score for now
	score_card.set_score(Global.number)
	pass



func _physics_process(delta):
	move_player(delta)
	check_floor()
	score_card.set_distance(-transform.origin.z)
	pass



func set_initial_position(_side):
	transform.origin.x = _side * SIDE_WIDTH
	animation_tree.set(anim_stance, STANCE_IDLE)
	pass



func move_player(delta):
	velocity.x = strafe_sideways(delta)
	velocity.y = 0
	velocity.z = move_forward(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	pass


func move_forward(delta):
	var fv = Global.clamp_vector(Vector3(0, 0, velocity.z), forward_speed)
	var new_pos = Vector3.FORWARD * forward_speed
	var fw_velocity = fv.linear_interpolate(new_pos, ACCELERATION * delta)
	set_run_animation(-fw_velocity.z)
	return fw_velocity.z



func strafe_sideways(delta):
	if Input.is_action_just_pressed("move_left_%s" % id):
		left_feeler.force_raycast_update()
		if !left_feeler.is_colliding():
			side = Global.SIDE.CENTER if side == Global.SIDE.RIGHT else Global.SIDE.LEFT
			set_strafe_animation(Global.SIDE.LEFT)
	elif Input.is_action_just_pressed("move_right_%s" % id):
		right_feeler.force_raycast_update()
		if !right_feeler.is_colliding():
			side = Global.SIDE.CENTER if side == Global.SIDE.LEFT else Global.SIDE.RIGHT
			set_strafe_animation(Global.SIDE.RIGHT)
	
	var target_pos = transform.origin
	target_pos.x = side * ROAD_WIDTH
	var target_velocity = target_pos - transform.origin
	var strafe_velocity = Global.clamp_vector(target_velocity * STRAFE_SPEED, STRAFE_SPEED)
	return (strafe_velocity * delta).x



func check_floor():
	if !front_feeler.is_colliding():
		emit_signal("detect_empty_floor")
	if rear_feeler.is_colliding():
		var target = rear_feeler.get_collider()
		if target.is_in_group("platform"):
			emit_signal("detect_obsolete_floor", -transform.origin.z, target)
	pass



func set_run_animation(speed):
	var stance = animation_tree.get(anim_stance)
	var lerpMax = 0
	if speed < 0.5:
		lerpMax = STANCE_IDLE
	elif speed < FORWARD_SPEED_PENALTY + 1:
		lerpMax = STANCE_WALK
	else:
		lerpMax = STANCE_RUN
	animation_tree.set(anim_stance, lerp(stance,lerpMax, 0.1))
	pass



func set_strafe_animation(strafe_mode):
	animation_tree.set(anim_strafe_mode, strafe_mode)
	animation_tree.set(anim_strafe, true)



func slow_down():
	animation_tree.set(anim_head_hit, true)
	forward_speed = FORWARD_SPEED_PENALTY
	score_card.set_boost(Global.STATUS.PENALTY)
	speed_timer.start()
	pass



func sprint(coin):
	forward_speed = FORWARD_SPEED_BONUS
	score += SCORE_INCREMENT
	#score_card.set_score(score)
	score_card.set_boost(Global.STATUS.SPRINT)
	score_feedback.set_coin_hit(coin)
	speed_timer.start()
	pass



func _on_SpeedTimer_timeout():
	forward_speed = FORWARD_SPEED_REGULAR
	score_card.set_boost(Global.STATUS.NORMAL)
	pass


func on_vicory():
	animation_tree.set(anim_victory, true)
	pass
