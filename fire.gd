extends TextureButton


func _on_pressed() -> void:
	GlobalGameManager.add_effect()


func _on_button_down() -> void:
	GlobalGameManager.firing = true


func _on_button_up() -> void:
	GlobalGameManager.firing = false
