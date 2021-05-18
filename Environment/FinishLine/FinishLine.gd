extends Spatial

signal player_wins(player_id)

func _on_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_wins", body.id)
