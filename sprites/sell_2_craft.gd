extends TextureButton

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://sprites/main.tscn")
	GlobalGameManager.to_craft.emit()
