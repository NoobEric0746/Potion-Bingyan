extends TextureButton


func _on_button_down() -> void:
	GlobalGameManager.set_watering(true)
	get_node("WaterParticle").emitting = true

func _on_button_up() -> void:
	GlobalGameManager.set_watering(false)
	get_node("WaterParticle").emitting = false


func _on_mouse_entered() -> void:
	GlobalGameManager.show_arrow = true


func _on_mouse_exited() -> void:
	GlobalGameManager.show_arrow = false
