extends TextureButton

@export var idx:int

func _on_pressed() -> void:
	get_parent().button_clicked(idx)

func _process(delta: float) -> void:
	if (not idx in GlobalGameManager.saved_potion) or GlobalGameManager.saved_potion[idx] == null:
		hide();
	else:
		show()


func _on_mouse_entered() -> void:
	GlobalGameManager.saved_potion_info = idx


func _on_mouse_exited() -> void:
	GlobalGameManager.saved_potion_info = 0
