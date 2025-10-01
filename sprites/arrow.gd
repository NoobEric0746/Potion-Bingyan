extends Sprite2D

func _process(delta: float) -> void:
	if GlobalGameManager.show_arrow:
		show()
	else:
		hide()
	var potion = get_parent().get_node("Potion")
	position = potion.position
	var direction = potion.start_pos - potion.global_position
	var angle_rad = direction.angle()
	rotation = angle_rad
