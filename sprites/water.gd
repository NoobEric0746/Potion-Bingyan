extends TextureButton


func _on_button_down() -> void:
	GlobalGameManager.set_watering(true)

func _on_button_up() -> void:
	GlobalGameManager.set_watering(false)


func _on_mouse_entered() -> void:
	GlobalGameManager.show_arrow = true


func _on_mouse_exited() -> void:
	GlobalGameManager.show_arrow = false
