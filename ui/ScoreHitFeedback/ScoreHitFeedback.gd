extends Control

onready var feedbackLabel = $FeedbackLabel
onready var anim_player = $AnimationPlayer


func set_coin_hit(coin):
	anim_player.stop(true)
	if coin == 0:
		feedbackLabel.text = "Hurray!!"
	else:
		feedbackLabel.text = "%d x %d = %d" % [coin / Global.number, Global.number, coin]
	anim_player.play("scale_anim")
