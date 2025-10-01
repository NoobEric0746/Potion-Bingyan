extends TextureButton


func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("yao_item"):
		handle_yao_caught(body)

func handle_yao_caught(yao_node:Node2D):
	#GlobalGameManager.set_now_ingredient(yao_node.get_ingredient_type())
	GlobalGameManager.add_ingredient(yao_node.get_ingredient_type())
	yao_node.queue_free()


func _on_button_down() -> void:
	GlobalGameManager.set_moving(true)


func _on_button_up() -> void:
	GlobalGameManager.set_moving(false)
