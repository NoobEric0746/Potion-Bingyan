extends TextureButton

@export var ingredient_type:int
var ok = true

func _on_pressed() -> void:
	if ok:
		GlobalGameManager.storage_data[ingredient_type] += 5
		get_node("Label").appear()
		await get_tree().create_timer(0.2).timeout
		hide()
