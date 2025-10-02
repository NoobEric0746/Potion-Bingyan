extends TextureButton



func _on_pressed() -> void:
	GlobalGameManager.kill_items.emit()
	get_tree().change_scene_to_file("res://sprites/sell.tscn")
